//
//  PGListingEnquiryResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 13/7/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGListingEnquiryResponse {
    public let stat: String
    public let success: Bool
}

struct PGListingEnquiryResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        let stat = bulldog.string("stat") ?? ""
        output = PGListingEnquiryResponse(stat: stat, success: stat == "ok")
    }

}
