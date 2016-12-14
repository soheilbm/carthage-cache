//
//  PGAlertResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 7/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import Foundation

struct PGUpdateAlertResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let stat = bulldog.string("stat"), stat == "ok" else { return nil }
        output = true
    }
    
}

struct PGGetAlertResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let values = bulldog.array("alerts") else { return nil }
        output = values.flatMap { item -> PGAlertResponse? in
            let itemDict = Bulldog(json: item)
            if let _id = itemDict.string("alert_id"), let _name = itemDict.string("alert_name"), let _type = itemDict.string("listing_type"), let _options = itemDict.dictionary() as? [String: Any?] {
                return PGAlertResponse(alertId: _id, alertName: _name, type: _type, options: _options)
            }
            return nil
        }
    }
    
}
