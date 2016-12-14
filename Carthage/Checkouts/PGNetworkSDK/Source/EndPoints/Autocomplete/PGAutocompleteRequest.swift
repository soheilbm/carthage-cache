//
//  PGAutocompleteRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 10/6/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGAutocompleteGeneralRequest: PGApiRequest {
    var apiPath: String? = PGApiPath("Autocomplete", "General")
    var parameters: [String: Any]?
    var httpMethod: PGRequestHttpMethod = .get
    var isAccessTokenRequired: Bool = true
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGAutocompleteResultResponseHandler.self
    let keyword: String
    let objectType: String
    public init(keyword: String, objectType: String = "DISTRICT, REGION, NEWPROJECT, DEVELOPER") {
        self.keyword = keyword
        self.objectType = objectType
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["region"] = value  }
        if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
        params["limit"] = 20 
        params["objectType"] = objectType 
        params["query"] = keyword 
        
        return params
    }
    
}
