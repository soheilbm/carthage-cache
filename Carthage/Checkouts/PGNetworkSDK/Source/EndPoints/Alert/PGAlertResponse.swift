//
//  PGAlertResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 7/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import Foundation

public struct PGAlertResponse {
    public var alertId: String
    public var alertName: String
    public var type: String
    public var options: [String: Any?]
}
