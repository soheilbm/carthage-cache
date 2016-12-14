//
//  PGAlertRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 7/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import Foundation

public struct PGCreateAlertRequest: PGApiRequest {
    
    public var baseUrl: String?
    var locale: String?
    let options: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGUpdateAlertResponseHandler.self
    var isAccessTokenRequired: Bool = true
    var httpMethod: PGRequestHttpMethod = .post
    
    public init(options: [String: String]? = nil, locale: String? = PGNetworkSDK.sharedInstance.locale) {
        self.options = options
        self.locale = locale
    }
    
    var apiPath: String? {
        guard let locale = self.locale else { return nil }
        return "/\(locale)/listing/saveSearchListing"
    }
    
    var parameters: [String: Any]? {
        return options
    }
    
}

public struct PGDeleteAlertRequest: PGApiRequest {
    
    public var baseUrl: String?
    var locale: String?
    let alertId: String
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGUpdateAlertResponseHandler.self
    var isAccessTokenRequired: Bool = true
    var httpMethod: PGRequestHttpMethod = .post
    
    public init(alertId: String, locale: String? = PGNetworkSDK.sharedInstance.locale) {
        self.alertId = alertId
        self.locale = locale
    }
    
    var apiPath: String? {
        guard let locale = self.locale else { return nil }
        return "/\(locale)/listing/deleteAlert/\(alertId)"
    }
    
    var parameters: [String: Any]?
    
}

public struct PGGetAlertRequest: PGApiRequest {
    
    public var baseUrl: String?
    var locale: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGGetAlertResponseHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(locale: String? = PGNetworkSDK.sharedInstance.locale) {
        self.locale = locale
    }
    
    var apiPath: String? {
        guard let locale = self.locale else { return nil }
        return "/\(locale)/listing/getSaveSearch"
    }
    
}
