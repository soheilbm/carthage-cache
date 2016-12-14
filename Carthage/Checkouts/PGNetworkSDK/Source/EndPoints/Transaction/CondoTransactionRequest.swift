//
//  CondoTransactionRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 18/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoTransactionRequest: PGApiRequest {
    public let condoId: String
    let type: String
    let orderBy: String
    let limit: Int
    let page: Int
    let filterParameter: [String: String]?
    var apiPath: String?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGCondoTransactionResponseHandler.self
    
    public init(condoId: String, orderBy: String, type: String, page: Int = 1, limit: Int = 25, filterParameter: [String: String]?) {
        self.condoId = condoId
        self.orderBy = orderBy
        self.type = type
        self.page = page
        self.limit = limit
        self.filterParameter = filterParameter
        if let path = PGApiPath("Condo", "detail") {
            apiPath = "\(path)/\(condoId)/\(type)"
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        params["limit"] = String(limit) 
        params["page"] = String(page) 
        params["fields"] = "all" 
        params["metadata"] = String(true) 
        params["orderby"] = orderBy 
        if let value = filterParameter {
            value.forEach { params[$0] = $1  }
        }
        return params
    }
    
}
