//
//  CondoListRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 2/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoListRequest: PGApiRequest {
    
    let typeGroup: String
    let isPrimaryBuilding: Bool
    let limit: Int
    public var latitude: Double?
    public var longitude: Double?
    public var otherQuery: [String: Any]?
    
    var apiPath: String? = PGApiPath("Condo", "list")
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGCondoListResponseHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(_ typeGroup: String = "N", isPrimaryBuilding: Bool = true, limit: Int = 50) {
        self.typeGroup = typeGroup
        self.isPrimaryBuilding = isPrimaryBuilding
        self.limit = limit
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["country"] = value  }
        if let value = PGNetworkSDK.sharedInstance.locale { params["lang"] =  value  }
        if let value = latitude { params["latitude"] = value  }
         if let value = longitude { params["longitude"] = value  }
        params["typeGroup"] =  typeGroup 
        params["isPrimaryBuilding"] = String(isPrimaryBuilding) 
        params["limit"] = limit 
        params["metadata"] = String(true) 
        params["pgDataSet"] = String(true) 
        if let other = otherQuery {
            for (k, v) in other {
                params.updateValue(v, forKey: k)
            }
        }
        
        return params
    }
    
}
