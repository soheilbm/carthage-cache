//
//  PGListingDetailRequest.swift
// PGNetworkSDK
//
//  Created by Soheil on 27/4/16.
//  Copyright © 2016 Soheil. All rights reserved.
//

import Foundation

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


public struct PGListingDetailRequest: PGApiRequest {
    let listingId: String
    let deviceId: String?
    let isTracked: Bool
    
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGListingDetailHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(_ id: String, deviceId: String = "", isTracked: Bool = false) {
        self.listingId = id
        self.deviceId = deviceId
        self.isTracked = isTracked
        if let apiPathDetail = PGApiPath("Listings", "Detail") {
            apiPath = "\(apiPathDetail)/\(listingId)"
        }
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["region"] = value  }
        if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
        if isTracked { params["_isTracked"] = "1"  }
        if let value = deviceId , deviceId?.characters.count > 0 { params["device_id"] = value  }
        return params
    }
    
}

public struct PGSimilarListingRequest: PGApiRequest {
    let listingId: String
    let deviceId: String?
    let isTracked: Bool
    let limit: Int
    
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGSimilarListingHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(_ id: String, limit: Int, deviceId: String = "", isTracked: Bool = false) {
        self.listingId = id
        self.deviceId = deviceId
        self.isTracked = isTracked
        self.limit = limit
        if let apiPathDetail = PGApiPath("Listings", "Detail") {
            apiPath = apiPathDetail
        }
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["region"] = value  }
        if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
        if isTracked { params["_isTracked"] = "1"  }
        if let value = deviceId , deviceId?.characters.count > 0 { params["device_id"] = value  }
        
        params["similar_listing_id"] =  listingId 
        params["limit"] = String(limit) 
        return params
    }
    
}
