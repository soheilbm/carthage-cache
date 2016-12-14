//
//  PropertySearchRequest.swift
//  PGNetworkSDK
//
//  Created by Kenneth Poon on 8/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PropertySearchRequest: PGApiRequest {
    
    public var baseUrl: String?
    public var locale: String?
    let query: String

    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PropertySearchListResponseHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(query: String) {
        self.query = query
    }
    
    var apiPath: String? {
        guard let locale = PGNetworkSDK.sharedInstance.locale else { return nil }
        let path = "/property/search"
        return "/\(locale)\(path)"
    }
    
    var parameters: [String: Any]? {
        let params: [String: Any] = ["q": self.query]
        return params
    }
    
}
