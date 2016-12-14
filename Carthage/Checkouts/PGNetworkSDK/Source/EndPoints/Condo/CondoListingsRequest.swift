//
//  CondoDirectory.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 2/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoListingsRequest: PGApiRequest {
    
    public enum CondoListingType: String {
        case sale, rent
    }
    
    let propertyId: String?
    let agentId: String?

    let listingType: CondoListingType
    let page: Int
    let limit: Int
    
    public var bedCount: Int?
    public var sortOption: [String: Bool]?
    
    var apiPath: String? = PGApiPath("Condo", "listings")
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGSimilarListingHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(id: String?, agentId: String? = nil, type: CondoListingType = .sale, page: Int = 1, limit: Int = 50) {
        self.propertyId = id
        self.agentId = agentId
        self.page = page
        self.limit = limit
        self.listingType = type
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["region"] = value  }
        if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
        if let value = propertyId { params["property_id"] =  value  }
        if let value = agentId { params["agent"] =  value  }
        
        params["listing_type"] = listingType.rawValue 
        params["limit"] = limit 
        params["page"] = page 
        if let value = bedCount {
            params["minbed"] = String(value) 
            params["maxbed"] = String(value) 
        }
        if let value = sortOption { value.forEach {
            params["sort"] = $0 
            params["order"] = sortKey(for: $1) 
            }
        } else {
            params["include_mobile_condospotlight_listing"] = String(true) 
        }
        return params
    }
    
    func sortKey(for bool: Bool) -> String {
        return bool ? "asc" : "desc"
    }
    
}
