//
//  PGListingDetailResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGSimilarListingHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        let total      = bulldog.double("total")
        let page       = bulldog.double("page")
        let limit      = bulldog.double("limit")
        let totalPages = bulldog.double("totalPages")
        let currency   = bulldog.string("currency")
        var listings: [PGListingDetail]  = []
        if let array = bulldog.array("listings") {
            listings = array.flatMap { return PGListingDetail(bulldog: Bulldog(json: $0)) }
        }
        
        output = PGSimilarListing(total: total, page: page, limit: limit, totalPages: totalPages, currency: currency, listings: listings)
        
    }
    
}

struct PGListingLocationHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGListingLocation(bulldog: bulldog)
    }

}

struct PGListingEmbededMediaHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGListingEmbededMedia(bulldog: bulldog)
    }

}

struct PGListingMediaHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGListingMedia(bulldog: bulldog)
    }
    
}

    
struct PGListingAgentHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGListingAgent(bulldog: bulldog)
    }
    
}

struct PGListingDetailDateHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGListingDetailDate(bulldog: bulldog)
    }

}

struct PGListingDetailHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog ) {
        output = PGListingDetail(bulldog: bulldog)
    }

}

struct PGListingDetailFeatureHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let code = bulldog.string("code"),
            let desc = bulldog.string("description") else { return nil }
        output = PGListingDetailFeature(code: code, codeDescription: desc)
    }

}
