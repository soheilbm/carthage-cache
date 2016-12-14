//
//  CondoCSAQueryResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 17/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoAgentListResponse {
    public var totalItems: Int
    public var currentPage: Int
    public var totalPages: Int
    public var agents: [PGCondoCSAQueryResponse]?
    
    init(count: Int, page: Int, totalPages: Int) {
        self.totalItems = count
        self.currentPage = page
        self.totalPages = totalPages
    }

}

public struct PGCondoCSAQueryResponse {
    public var agentId: Int
    public var advertiserName: String?
    public var advertiserImageUrl: String?
    public var advertiserPhoneNumberToCall: String?
    public var agencyName: String?
    public var ceaLicenseNo: String?
    public var ceaSalespersonNo: String?
    
    init(agentId: Int) {
        self.agentId = agentId
    }
    
}
