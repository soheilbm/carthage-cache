//
//  CondoListResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGCondoListResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let totalItems = bulldog.int("metadata", "totalItems"),
            let totalPages = bulldog.int("metadata", "totalPages"),
            let currentPage = bulldog.int("metadata", "currentPage") else { return nil }
        
        var list = PGCondoListResponse(count: totalItems, page: currentPage, totalPages: totalPages)
        if let condos = bulldog.array("response") {
            list.condos = condos.flatMap { return PGCondoDetailResponse.init(bulldog: Bulldog(json: $0)) }
        }
        output = list
    }
    
}
