//
//  PGAgentResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 22/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGAgentListResponse {
    public let list: [PGAgentResponse]?
}

public struct PGAgentResponse {
    
    public let agentId: String
    public let agencyName: String
    public let name: String
    public let mobile: String
    
    public var detail: String?
    public var logoUrl: String?
    public var photoUrl: String?
    
    public var headline: String?
    public var lineOne: String?
    public var lineTwo: String?
    public var bottomLine: String?
    
    init(id: String, name: String, agency: String, mobile: String) {
        self.agentId = id
        self.agencyName = agency
        self.name = name
        self.mobile = mobile
    }
    
}

public struct PGAgentDetailResponse {
    
    public let agentId: String
    public let name: String
    public let mobile: String
    
    public var agencyName: String?
    
    public var detail: String?
    public var logoUrl: String?
    public var photoUrl: String?

    public var headline: String?
    public var lineOne: String?
    public var lineTwo: String?
    public var bottomLine: String?
    
    public var ceaNo: String?
    public var ceaLicense: String?

    public var jobTitle: String?
    public var website: String?
    
    init(id: String, name: String, mobile: String) {
        self.agentId = id
        self.name = name
        self.mobile = mobile
    }
    
}
