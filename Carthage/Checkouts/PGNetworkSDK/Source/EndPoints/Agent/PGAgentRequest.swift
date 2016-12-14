//
//  PGAgentRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 22/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGAgentRequest: PGApiRequest {
    
    public var baseUrl: String?
    var locale: String?
    let otherParameters: [String: String]?
    let agentType: String
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGAgentListResponseHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(agentType: String, otherParameters: [String: String]? = nil, locale: String? = PGNetworkSDK.sharedInstance.locale) {
        self.agentType = agentType.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? agentType
        self.otherParameters = otherParameters
        self.locale = locale
    }
    
    var apiPath: String? {
        guard let locale = self.locale else { return nil }
        return "/\(locale)/agent/\(agentType)"
    }
    
    var parameters: [String: Any]? {
        return otherParameters as [String : Any]?
    }
    
}

public struct PGAgentDetailRequest: PGApiRequest {
    
    public var baseUrl: String?
    var locale: String?
    let agentId: String
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGAgentDetailResponseHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(agentId: String, locale: String? = PGNetworkSDK.sharedInstance.locale) {
        self.agentId = agentId
        self.locale = locale
    }
    
    var apiPath: String? {
        guard let locale = self.locale else { return nil }
        let path = "/agent/view"
        return "/\(locale)\(path)/\(agentId)"
    }
    
}
