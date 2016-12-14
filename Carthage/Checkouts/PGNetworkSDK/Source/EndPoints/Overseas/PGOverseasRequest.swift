//
//  PGOverseasRequest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 29/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGOverseasListRequest: PGApiRequest {
    public var countryCode: String?
    public var userId: String?
    public var limit: Int = 10
    public var page: Int = 1
    public var topYear: String?
    public var typeCode: String?
    public var sortCriteria: PGListSortCriteria?
    public var hasReview: Bool?
    public var freeText: String?
    
    var apiPath: String? = PGApiPath("Overseas", "List")
    
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGDeveloperProjectListHandler.self
    
    public init() {
    }
    
    var parameters: [String: Any]? {
        get {
            var params = [String: Any]()
            if let value = PGNetworkSDK.sharedInstance.country { params["targetCountry"] = value  }
            if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
            if let value = userId { params["userId"] =  value  }
            if let value = countryCode { params["countryCode"] =  value  }
            if let value = topYear { params["topYear"] =  value  }
            if let value = typeCode { params["propertyType"] =  value  }
            if let value = hasReview { params["hasReview"] =  value  }
            if let value = freeText { params["freeText"] =  value  }
            if let value = sortCriteria {
                for (k, v) in value.sortParameters() {
                    params.updateValue(v, forKey: k)
                }
            }
            params["page"] = page 
            params["limit"] = limit 
            
            return params
        }
    }
}

public struct PGOverseasDetailRequest: PGApiRequest {
    var propertyId: String
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGDeveloperProjectDetailHandler.self
    
    public init(id: String) {
        propertyId = id
        if let apiPathDetail = PGApiPath("Overseas", "Detail") {
            apiPath = "\(apiPathDetail)/\(propertyId)"
        }
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["targetCountry"] = value  }
        if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
        return params
    }
    
}

public struct PGOverseasCountryListRequest: PGApiRequest {
    var apiPath: String? = PGApiPath("Overseas", "CountryList")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGOverseasCountryListHandler.self
    public init() {
        apiPath = PGApiPath("Overseas", "CountryList")
        parameters = getParameters()
    }

    func getParameters() -> [String: Any]? {
        var params = [String: Any]()
        params["format"] = "verbose" 
        if let value = PGNetworkSDK.sharedInstance.country { params["targetCountry"] = value  }
        if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
        return params
    }
    
}
