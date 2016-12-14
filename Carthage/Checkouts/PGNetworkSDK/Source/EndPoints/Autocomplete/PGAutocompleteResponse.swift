//
//  PGAutocompleteResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 10/6/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGAutocompleteResultResponse {
    public var list: [PGAutocompleteItemResponse]?
}

public struct PGAutocompleteItemResponse {
    public let objectId: String
    public let objectType: String
    public let displayText: String
    public let displayType: String
    public let totalWeight: Int

    public var displayDescription: String?
    public var properties: [String: String]?
    public var allProperties: PGAutoCompleteObjectProperties?
    
    init(id: String, type: String, displayType: String, displayText: String, weight: Int) {
        self.objectId = id
        self.objectType = type
        self.displayType = displayType
        self.displayText = displayText
        self.totalWeight = weight
    }
    
}

public struct PGAutoCompleteObjectProperties {
    public let region: String?
    public let district: String?
    public let latitude: Double?
    public let longitude: Double?
    public let area: String?
    public let propertyTypeGroup: String?
}
