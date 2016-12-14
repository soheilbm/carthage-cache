//
//  PGOverseasResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 20/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGOverseasCountryListHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        let countries = bulldog.array()?.flatMap { return PGOverseasCountryItemHandler(bulldog: Bulldog(json: $0))?.output as? PGOverseasCountryItem }
        if let list = countries {
        	output = PGOverseasCountryList(countries: list)
        }
    }

}

struct PGOverseasCountryItemHandler: PGResponse {
    
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let name = bulldog.string("name"),
        	let code = bulldog.string("code"),
            let countString = bulldog.string("count") else { return nil }
        output = PGOverseasCountryItem(name: name, code: code, count: Int(countString) ?? 0)
    }

}
