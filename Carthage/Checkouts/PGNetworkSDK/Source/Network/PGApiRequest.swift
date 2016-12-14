//
//  PGApiiRequest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 24/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

protocol PGApiRequest: PGRequest, PGRequestAction {
    var isAccessTokenRequired: Bool { get }
    var baseUrl: String? { get }
    var locale: String? { get }
    var responseHandler: PGResponse.Type { get }
}

extension PGApiRequest {
    var basicAuthUsername: String? { return  PGNetworkSDK.sharedInstance.basicAuthUsername }
    var basicAuthPassword: String? { return  PGNetworkSDK.sharedInstance.basicAuthPassword }
    var isAccessTokenRequired: Bool { return true }
    var baseUrl: String? { return PGNetworkSDK.sharedInstance.baseUrl }
    var locale: String? { return PGNetworkSDK.sharedInstance.locale }
    
    var fullApiPath: String? {
        get {
            #if DEBUG
                print("base url \(baseUrl) , apiPath \(apiPath)")
            #endif
            guard let url = baseUrl, let thisApiPath = apiPath else { return nil }
            return url.appending(thisApiPath)
        }
    }
    
    var requestParameters: [String: Any]? {
        get {
            if let token = PGNetworkSDK.sharedInstance.networkAccessToken, isAccessTokenRequired {
                if var params = parameters {
                    params["access_token"] = token
                    return params
                } else {
                    return ["access_token": token]
                }
            } else {
            	return parameters
            }
        }
    }
}

public protocol PGRequestAction {
	func send(queue: DispatchQueue?, success: @escaping ((Any?) -> Void), failure: @escaping ((PGNetworkError) -> Void))
    func cancel()
}

extension PGRequestAction {
    
    public func send(queue: DispatchQueue? = nil, success: @escaping ((Any?) -> Void), failure: @escaping ((PGNetworkError) -> Void)) {
        guard let apiRequest = self as? PGApiRequest else {
            failure(PGNetworkError.invalidError)
            return
        }
        apiRequest.networkManager.request(queue, request: apiRequest, success: { json in
            guard let response = apiRequest.responseHandler.init(bulldog: Bulldog(json: json))?.output else { failure(PGNetworkError.parsingError)
                return
            }
            success(response)
        }, failure: failure)
    }
    
    public func cancel() {
        guard let apiRequest = self as? PGApiRequest else { return }
        apiRequest.networkManager.cancelRequest(apiRequest)
    }
    
}
