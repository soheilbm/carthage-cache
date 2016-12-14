//
//  PropertyLocationRequest.swift
//  PGNetworkSDK
//
//  Created by Kenneth Poon on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PropertyLocationRequest: PGApiRequest {
    
    public var baseUrl: String?
    public var locale: String?
    let propertyId: String

    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    
    var responseHandler: PGResponse.Type = PropertyLocationListResponseHandler.self

    var isAccessTokenRequired: Bool = false
    
    public init(propertyId: String) {
        self.propertyId = propertyId
    }
    
    var apiPath: String? {
        guard let locale = PGNetworkSDK.sharedInstance.locale else { return nil }
        let path = "/property/getLocations"
        return "/\(locale)\(path)"
    }
    
    var parameters: [String: Any]? {
        let params: [String: Any] = ["propertyid": self.propertyId]
        return params
    }
    
}
