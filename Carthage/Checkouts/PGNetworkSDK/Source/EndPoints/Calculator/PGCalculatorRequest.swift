//
//  PGCalculatorRequest.swift
//  PGSDK
//
//  Created by Soheil on 15/5/16.
//  Copyright © 2016 Soheil. All rights reserved.
//

import Foundation


public struct PGCalculatorRequest: PGApiRequest {
    let listingId: String
    let location: String
    let language: String?
    let source: String
    
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGCalculatorHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(_ id: String, location: String = "top", language: String? = PGNetworkSDK.sharedInstance.locale, source: String = "app") {
        self.listingId = id
        self.location = location
        self.language = language ?? PGNetworkSDK.sharedInstance.locale
        self.source = source
        
        if let apiPathDetail = PGApiPath("Calculator") { apiPath = apiPathDetail }
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["country"] = value  }
        if let value = PGNetworkSDK.sharedInstance.country { params["region"] = value  }
        if let value = language { params["language"] = value  }
        
        
        params["location"] = location 
        params["source"] = source 
        return params
    }
    
}
