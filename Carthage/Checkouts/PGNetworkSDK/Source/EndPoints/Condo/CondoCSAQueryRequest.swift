//
//  CondoCSAQueryRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 17/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoCSAQueryRequest: PGApiRequest {
    let condoId: String?
    let page: Int
    let limit: Int
    var apiPath: String? = PGApiPath("Condo", "csaQuery")
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGCondoAgentListResponseHandler.self
    let districtCode: String?
    public init(condoId: String?, districtCode: String? = nil, page: Int = 1, limit: Int = 50) {
        self.condoId = condoId
        self.districtCode = districtCode
        self.page = page
        self.limit = limit
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        if let country = PGNetworkSDK.sharedInstance.country,
            let locale = PGNetworkSDK.sharedInstance.locale {
            params["country"] = country 
            params["lang"] = locale 
        }
        params["page"] = page 
        params["limit"] = limit 
        params["typeCode"] = "CSPOT" 
        if let value = condoId { params["propertyId"] = value  }
        if let value = districtCode { params["districtCode"] = value  }
        return params
    }
    
}
