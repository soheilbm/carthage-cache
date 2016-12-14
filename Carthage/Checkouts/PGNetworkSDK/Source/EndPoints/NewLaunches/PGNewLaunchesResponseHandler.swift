//
//  PGNewLaunchesResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 20/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGNewLaunchesConstantHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        output = PGNewLaunchesConstant(bulldog: bulldog)
    }
}

struct PGPropertySearchPriceHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        output = PGPropertySearchPrice(bulldog: bulldog)
    }
}


struct PGNewLaunchesEnquiryResponseHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        output = PGNewLaunchesEnquiryResponse(bulldog: bulldog)
    }
}
