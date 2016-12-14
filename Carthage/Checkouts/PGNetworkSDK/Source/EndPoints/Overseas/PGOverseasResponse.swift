//
//  PGOverseasResponse.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 29/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGOverseasCountryList {
    public let countries: [PGOverseasCountryItem]
}

public struct PGOverseasCountryItem {
    public let name: String
    public let code: String
    public let count: Int
}
