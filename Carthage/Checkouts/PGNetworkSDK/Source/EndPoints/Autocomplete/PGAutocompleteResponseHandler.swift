//
//  PGAutocompleteResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGAutocompleteResultResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        if let list = bulldog.array() {
            let items = list.flatMap { return PGAutocompleteItemResponseHandler(bulldog: Bulldog(json: $0))?.output as? PGAutocompleteItemResponse }
            output = PGAutocompleteResultResponse(list: items)
        }
    }

}

struct PGAutocompleteItemResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let objectType = bulldog.string("objectType"),
            let objectId = bulldog.string("objectId"),
            let displayText = bulldog.string("displayText"),
            let displayType = bulldog.string("displayType") else { return nil }
        var item = PGAutocompleteItemResponse(id: objectId, type: objectType, displayType: displayType, displayText: displayText, weight: bulldog.int("totalWeight") ?? 0)
        
        item.displayDescription = bulldog.string("displayDescription")
        item.properties = parseObjectAndId(objectType, objectId: objectId)
        if let propJson = bulldog.rawJson("properties") {
        	item.allProperties = PGAutoCompleteObjectPropertiesHandler(bulldog: Bulldog(json: propJson))?.output as? PGAutoCompleteObjectProperties
        }
        output = item
    }
    
    fileprivate enum AutocompleteObjectType: String {
        case DEVELOPER, REGION, NEWPROJECT, DISTRICT
    }
    
    func parseObjectAndId(_ objectType: String, objectId: String) -> [String: String]? {
        if let type = AutocompleteObjectType(rawValue: objectType) {
            switch type {
            case .DEVELOPER: return ["userId": objectId]
            case .DISTRICT: return ["districtCode": objectId]
            case .REGION: return ["regionCode": objectId]
            case .NEWPROJECT: return ["listingId": objectId]
            }
        }
        return nil
    }
    
}

struct PGAutoCompleteObjectPropertiesHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        let region = bulldog.string("region")
        let district = bulldog.string("district")
        let latitude = bulldog.double("latitude")
        let longitude = bulldog.double("longitude")
        let area = bulldog.string("area")
        let propertyTypeGroup = bulldog.string("propertyTypeGroup")
        output = PGAutoCompleteObjectProperties(region: region, district: district, latitude: latitude, longitude: longitude, area: area, propertyTypeGroup: propertyTypeGroup)
    }
    
}
