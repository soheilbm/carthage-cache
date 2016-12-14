//
//  PGNewsRequest.swift
//  Pods
//
//  Created by Suraj Pathak on 11/3/16.
//
//

import Foundation

public struct PGFeaturedArticleRequest: PGApiRequest {
    public var count: UInt = 1
    var apiPath: String? = PGApiPath("News", "List")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGNewsListHandler.self
    public init(count: UInt) {
        self.count = count
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params: [String: Any] = ["limit": count, "featured": true]
        if let country = PGNetworkSDK.sharedInstance.country,
            let locale = PGNetworkSDK.sharedInstance.locale {
            params["country"] = country 
            params["lang"] = locale 
        }
        return params
    }
    
}


public struct PGCategoriesRequest: PGApiRequest {
    var apiPath: String? = PGApiPath("News", "Categories")
    var responseHandler: PGResponse.Type = PGNewsCategoryListHandler.self
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    public init() {
        responseHandler = PGNewsCategoryListHandler.self
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        if let country = PGNetworkSDK.sharedInstance.country,
            let locale = PGNetworkSDK.sharedInstance.locale {
                return ["country": country, "lang": locale]
            }
        return nil
    }
    
}

public struct PGNewsInCategoryRequest: PGApiRequest {
    public var page: UInt
    public var slug: String?
    
    var apiPath: String? = PGApiPath("News", "List")
    var responseHandler: PGResponse.Type = PGNewsListHandler.self
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    
    public init(page: UInt, slug: String?, isFeatured: Bool? = false) {
        self.page = page
        self.slug = slug
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params: [String: Any] = ["page": page, "limit": 10]
        if let categorySlug = slug {
            params["category"] = categorySlug 
        }
        if let country = PGNetworkSDK.sharedInstance.country,
            let locale = PGNetworkSDK.sharedInstance.locale {
                params["country"] = country 
                params["lang"] = locale 
        }
        return params
    }
    
}

public struct PGLatestNewsRequest: PGApiRequest {
    public var page: UInt
    
    var apiPath: String? = PGApiPath("News", "List")
    var responseHandler: PGResponse.Type = PGNewsListHandler.self
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    
    public init(page: UInt) {
        self.page = page
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params: [String: Any] = ["page": page, "limit": 10]
        if let country = PGNetworkSDK.sharedInstance.country,
            let locale = PGNetworkSDK.sharedInstance.locale {
            params["country"] = country 
            params["lang"] = locale 
        }
        return params
    }
    
}

public struct PGNewsFullRequest: PGApiRequest {
    public var id: String
    var apiPath: String? = PGApiPath("News", "Detail")
    var responseHandler: PGResponse.Type = PGNewsFullHandler.self
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    public init(id: String) {
        self.id = id
        apiPath = PGApiPath("News", "Detail")
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        var params: [String: Any] = ["id": id]
        if let country = PGNetworkSDK.sharedInstance.country,
            let locale = PGNetworkSDK.sharedInstance.locale {
            params["country"] = country 
            params["lang"] = locale 
        }
        return params
    }
    
}
