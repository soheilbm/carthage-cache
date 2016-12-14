//
//  PropertySearchResponse.swift
//  PGNetworkSDK
//
//  Created by Kenneth Poon on 8/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PropertySearchListResponseHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        
        if let propertyArray = bulldog.array("property") {        
            var listResponse = PropertySearchListResponse()
            var list = [PropertySearchResponse]()
            for property in propertyArray {
                
                
                guard let response = PropertySearchResponseHandler.init(bulldog: Bulldog(json: property))?.output as? PropertySearchResponse else {
                    continue
                }
                list.append(response)
            }
            listResponse.list = list
            output = listResponse
        }
        
    }       
}

struct PropertySearchResponseHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        
        var response = PropertySearchResponse()
        response.propertyId = bulldog.int("property_id")
        response.propertyName = bulldog.string("property_name")
        response.typeGroup = bulldog.string("property_type_group")
        response.typeCode = bulldog.string("property_type_code")
        
        response.streetName = bulldog.string("streetname")
        response.streetNumber = bulldog.string("streetnumber")
        response.estateCode = bulldog.int("estate_code")
        response.regionCode = bulldog.string("region_code")
        response.districtCode = bulldog.string("district_code")
        response.areaCode = bulldog.string("area_code")
        response.postalCode = bulldog.string("postcode")
        
        response.latitude = bulldog.double("latitude")
        response.longitude = bulldog.double("longitude")

        response.tenure = bulldog.string("tenure")
        response.topYear = bulldog.int("top_year")

        output = response
        
    }       
}

