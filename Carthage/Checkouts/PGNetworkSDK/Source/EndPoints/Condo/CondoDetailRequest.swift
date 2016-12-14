//
//  CondoDetailRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 2/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoDetailRequest: PGApiRequest {
    public let condoId: String
    var apiPath: String?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGCondoDetailResponseHandler.self
    
    public init(condoId: String) {
        self.condoId = condoId
        if let path = PGApiPath("Condo", "detail") {
        	apiPath = "\(path)/\(condoId)"
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        if let country = PGNetworkSDK.sharedInstance.country,
            let locale = PGNetworkSDK.sharedInstance.locale {
            params["country"] = country 
            params["lang"] = locale 
            params["pgDataSet"] = true 
        }
        return params
    }
    
}
