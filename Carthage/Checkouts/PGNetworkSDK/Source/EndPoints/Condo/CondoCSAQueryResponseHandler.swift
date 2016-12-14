//
//  CondoCSAQueryResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGCondoAgentListResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let totalItems = bulldog.int("total"),
            let totalPages = bulldog.int("page"),
            let currentPage = bulldog.int("page") else { return nil }
        
        var listResponse = PGCondoAgentListResponse(count: totalItems, page: currentPage, totalPages: totalPages)
        
        if let agents = bulldog.array("records") {
            listResponse.agents = agents.flatMap { return PGCondoCSAQueryResponseHandler(bulldog: Bulldog(json: $0))?.output as? PGCondoCSAQueryResponse }
        }
        output = listResponse
    }

}

struct PGCondoCSAQueryResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let agentId = bulldog.int("agentId") else { return nil }
        var csaAgent = PGCondoCSAQueryResponse(agentId: agentId)
        csaAgent.advertiserName = bulldog.string("name")
        csaAgent.advertiserImageUrl = bulldog.string("agentPhoto")
        csaAgent.advertiserPhoneNumberToCall = bulldog.string("mobile")
        csaAgent.agencyName = bulldog.string("agencyName")
        csaAgent.ceaLicenseNo = bulldog.string("ceaLicenseNo") ?? ""
        csaAgent.ceaSalespersonNo = bulldog.string("ceaSalespersonNo") ?? ""
        
        output = csaAgent
        
    }
    
}
