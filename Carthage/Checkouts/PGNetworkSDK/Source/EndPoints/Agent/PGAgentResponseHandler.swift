//
//  PGAgentResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGAgentListResponseHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        
        if let agentArray = bulldog.array("agent") {
            let list = agentArray.flatMap { PGAgentResponseHandler.init(bulldog: Bulldog(json: $0))?.output as? PGAgentResponse }
            output = PGAgentListResponse(list: list)
        } else if let agentsArray = bulldog.array("agents") {
            let list = agentsArray.flatMap { PGAgentResponseHandler.init(bulldog: Bulldog(json: $0))?.output as? PGAgentResponse }
            output = PGAgentListResponse(list: list)
        }
    }
    
}

struct PGAgentResponseHandler: PGResponse {

    var output: Any?
    
    init?(bulldog: Bulldog ) {
        guard let _id = bulldog.stringFromPossibleInt("agent_id"),
            let _agency = bulldog.string("agency_name"),
            let _name = bulldog.string("name"),
            let _mobile = bulldog.string("mobile") else { return nil }
        var agent = PGAgentResponse(id: _id, name: _name, agency: _agency, mobile: _mobile)
        
        agent.detail = bulldog.string("description")
        agent.logoUrl = bulldog.string("logo_url")
        agent.photoUrl = bulldog.string("photo_url")
        
        agent.headline = bulldog.string("headline")
        agent.lineOne = bulldog.string("line_one")
        agent.lineTwo = bulldog.string("line_two")
        agent.bottomLine = bulldog.string("bottom_lin")
        
        output = agent
    }
    
}

struct PGAgentDetailResponseHandler: PGResponse {
    
    var output: Any?
    
    init?(bulldog: Bulldog ) {
        guard let _id = bulldog.stringFromPossibleInt("agent_id"),
            let _name = bulldog.string("agent_name"),
            let _mobile = bulldog.string("contact_number") else { return nil }
        var agent = PGAgentDetailResponse(id: _id, name: _name, mobile: _mobile)
        
        agent.agencyName = bulldog.string("company_name")
        agent.detail = bulldog.string("description")
        agent.logoUrl = bulldog.string("logo_url")
        agent.photoUrl = bulldog.string("photo_url")
        
        agent.headline = bulldog.string("headline")
        agent.lineOne = bulldog.string("line_one")
        agent.lineTwo = bulldog.string("line_two")
        agent.bottomLine = bulldog.string("bottom_line")
        
        agent.ceaNo = bulldog.string("agent_cea_salesperson_no")
        agent.ceaLicense = bulldog.string("agency_cea_license_no")
        
        agent.jobTitle = bulldog.string("job_title")
        
        output = agent
    }
    
}
