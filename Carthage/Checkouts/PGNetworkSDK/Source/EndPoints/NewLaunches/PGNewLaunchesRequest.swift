//
//  NewLaunchesRequest.swift
//  Pods
//
//  Created by Suraj Pathak on 23/3/16.
//
//

import Foundation

public enum PGListSortCriteria {
    case `default`
    case sortByDate(ascending: Bool)
    case sortByPrice(ascending: Bool)
    
    func sortParameters() -> [String: Any] {
        switch self {
        case .sortByDate(let ascending):
            let order = ascending ? "asc" : "desc"
            return ["sort": "date", "order": order]
        case .sortByPrice(let ascending):
            let order = ascending ? "asc" : "desc"
            return ["sort": "price", "order": order]
        default: return [:]
        }
    }
    
}

public enum PGFeaturedProjectBlock: String {
    case None = ""
    case HomePage = "homepage"
}

public struct PGFeaturedProjectsRequest: PGApiRequest {
    var apiPath: String?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGFeaturedProjectsHandler.self
    var parameters: [String: Any]?
    
    public init(block: PGFeaturedProjectBlock, country: String? = nil){
        if var path = PGApiPath("NewLaunches", "Featured") {
            if let t = country {
                path = "\(path)/\(t)"
            }
            else {
                if let t = PGNetworkSDK.sharedInstance.country { path = "\(path)/\(t)" }
            }
            path = "\(path)/\(block.rawValue)"
            self.apiPath = path
        }
    }
}

public struct PGNewLaunchesListRequest: PGApiRequest {
    public var regionCode: String?
    public var userId: String?
    public var limit: Int = 10
    public var page: Int = 1
    public var districtCode: String?
    public var sortCriteria: PGListSortCriteria?
    public var topYear: String?
    public var minPrice: Int?
    public var maxPrice: Int?
    public var typeCode: String?
    public var hasReview: Bool?
    public var freeText: String?
    public var excludeId: String?
    
    var apiPath: String? = PGApiPath("NewLaunches", "List")
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGDeveloperProjectListHandler.self
    
    public init() {}
    var parameters: [String: Any]? {
        get {
            var params = [String: Any]()
            if let value = PGNetworkSDK.sharedInstance.country { params["targetCountry"] = value  }
            if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
            if let value = userId { params["userId"] =  value  }
            if let value = regionCode { params["regionCode"] =  value  }
            if let value = districtCode { params["disctrictCode"] =  value  }
            if let value = topYear { params["topYear"] =  value  }
            if let value = typeCode { params["propertyType"] =  value  }
            if let value = hasReview { params["hasReview"] =  value  }
            if let value = freeText { params["keyword"] =  value  }
            if let value = excludeId { params["excludeId"] =  value  }
            if let value = minPrice , value > 0 { params["minPrice"] =  value  }
            if let value = maxPrice , value > 0 { params["maxPrice"] =  value  }
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

public struct PGNewLaunchesDetailRequest: PGApiRequest {
    var propertyId: String
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGDeveloperProjectDetailHandler.self
    
    public init(id: String) {
        propertyId = id
        if let apiPathDetail = PGApiPath("NewLaunches", "Detail") {
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

public struct PGNewLaunchesReviewRequest: PGApiRequest {
    public var reviewId: String
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGDeveloperProjectReviewItemHandler.self
    
    public init(id: String) {
        reviewId = id
        apiPath = getApiPath()
    }
    
    func getApiPath() -> String? {
        guard let apiPathReview = PGApiPath("NewLaunches", "Review") else { return nil }
        return "\(apiPathReview)/\(reviewId)"
    }
    
}

public struct PGNewLaunchesReviewListRequest: PGApiRequest {
    public var page: Int = 1
    public var limit: Int = 10
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGDeveloperProjectReviewListHandler.self
    
    
    public init() {
        apiPath = getApiPath()
        parameters = ["page": page, "limit": limit]
    }
    
    func getApiPath() -> String? {
        guard let country = PGNetworkSDK.sharedInstance.country,
            let locale = PGNetworkSDK.sharedInstance.locale,
            let apiPathReview = PGApiPath("NewLaunches", "ReviewList") else { return nil }
        return "\(apiPathReview)/\(country)/\(locale)"
    }
    
}

public struct PGNewLaunchesConstantsRequest: PGApiRequest {
    var apiPath: String? = PGApiPath("NewLaunches", "Constants")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGNewLaunchesConstantHandler.self
    public init() {
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["targetCountry"] = value  }
        if let value = PGNetworkSDK.sharedInstance.locale { params["locale"] =  value  }
        return params
    }
    
}

public struct PGNewLaunchesEnquiryRequest: PGApiRequest {
    var apiPath: String? = PGApiPath("NewLaunches", "Enquiry")
    var parameters: [String: Any]?
    var httpMethod: PGRequestHttpMethod = .post
    var isAccessTokenRequired: Bool = true
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGNewLaunchesEnquiryResponseHandler.self
    // Basic Authentication
    public var basicAuthPassword: String?
    public var basicAuthUsername: String?
    public var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl // Making this variable public for legacy api
    
    let listingId: String
    let name: String
    let email: String
    let phone: String
    let message: String?
    let nric: String?
    let address: String?
    
    public init(listingId: String, name: String, email: String, phone: String, message: String? = nil, nric: String? = nil, address: String? = nil) {
        self.listingId = listingId
        self.name = name
        self.email = email
        self.phone = phone
        self.message = message
        self.nric = nric
        self.address = address
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country {
            params["region"] = value 
            params["contactLocation"] =  value 
        }
        params["listingId"] = listingId 
        params["name"] = name 
        params["email"] = email 
        params["phone"] = phone 
        if let value = message { params["message"] = value  }
        var customdata: [String: String] = [:]
        if let value = nric { customdata["NRIC"] = value }
        if let value = address { customdata["HOMEADDR"] = value }
        params["enquiryType"] = "DEV" 
        if customdata.count > 0 {
            params["customData"] = customdata 
        }
        return params
    }
    
}
