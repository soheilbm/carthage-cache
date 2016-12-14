//
//  ShortlistRequest.swift
//  PGSDK
//
//  Created by Soheil on 15/5/16.
//  Copyright © 2016 Soheil. All rights reserved.
//

import Foundation

public struct PGShortlistGetRequest: PGApiRequest {
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGShortListRequestHandler.self
    var baseUrl: String?
    
    public init(baseUrl: String?) {
        if let url = baseUrl { self.baseUrl = url }
        if let apiPathDetail = PGApiPath("Shortlist", "Get") {
            apiPath = apiPathDetail
        }
    }
}

public struct PGShortlistAddRequest: PGApiRequest {
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGShortListUpdateRequestHandler.self
    var baseUrl: String?
    
    public init(baseUrl: String?, id: String) {
        if let url = baseUrl { self.baseUrl = url }
        
        if let apiPathDetail = PGApiPath("Shortlist", "Add") {
            apiPath = "\(apiPathDetail)/\(id)"
        }
    }
}

public struct PGShortlistRemoveRequest: PGApiRequest {
    var apiPath: String?
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGShortListUpdateRequestHandler.self
    var baseUrl: String?
    
    public init(baseUrl: String?, id: String) {
        if let url = baseUrl { self.baseUrl = url }
        
        if let apiPathDetail = PGApiPath("Shortlist", "Remove") {
            apiPath = "\(apiPathDetail)/\(id)"
        }
    }
}
