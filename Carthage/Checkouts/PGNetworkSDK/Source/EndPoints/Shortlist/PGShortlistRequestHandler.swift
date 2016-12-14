//
//  PGShortlistRequestHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 4/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import Foundation

struct PGShortListRequestHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let array = bulldog.array("listings") else { return nil }
        output = array.flatMap { return PGShortlist(bulldog: Bulldog(json: $0)) }
    }
    
}

struct PGShortListUpdateRequestHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let stat = bulldog.string("stat"), stat == "ok" else { return nil }
        output = true
    }
}
