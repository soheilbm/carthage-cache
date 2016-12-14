//
//  CondoDetailResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGCondoDetailResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGCondoDetailResponse(bulldog: bulldog)
    }
    
}

final class CondoDetailMediaHandler: PGResponse {
    
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let fileType = bulldog.string("fileType"),
            let url = bulldog.string("media") else { return nil }
        output = CondoDetailMedia(fileType: fileType, url: url, caption: bulldog.string("caption"))
    }
    
}
