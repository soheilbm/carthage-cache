//
//  PropertyLocationResponse.swift
//  PGNetworkSDK
//
//  Created by Kenneth Poon on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PropertyLocationListResponseHandler: PGResponse {
    
    var output: Any?
    init?(bulldog: Bulldog) {
        
        if let locationsArray = bulldog.array("locations") {
            
            var listResponse = PropertyLocationListResponse()
            var list = [PropertyLocationResponse]()
            for location in locationsArray {
             
                
                guard let response = PropertyLocationResponseHandler.init(bulldog: Bulldog(json: location))?.output as? PropertyLocationResponse else {
                    continue
                }
                list.append(response)
            }
            listResponse.list = list
            output = listResponse
        }

    }    
}

struct PropertyLocationResponseHandler: PGResponse {
    
    var output: Any?
    init?(bulldog: Bulldog) {
        var response = PropertyLocationResponse()   
        
        response.locationId = bulldog.int("location_id")
        response.propertyId = bulldog.int("property_id")
        response.propertyName = bulldog.string("property_name")
        response.typeGroup = bulldog.string("property_type_group")
        response.typeCode = bulldog.string("property_type")
        
        response.streetName = bulldog.string("streetname")
        response.streetNumber = bulldog.string("streetnumber")
        
        response.estateCode = bulldog.int("estate_code")
        response.regionCode = bulldog.string("region_code")
        response.districtCode = bulldog.string("district_code")
        response.areaCode = bulldog.string("area_code")
        response.postalCode = bulldog.string("postcode")
        
        response.latitude = bulldog.double("latitude")
        response.longitude = bulldog.double("longitude")
        
        output = response

    }
}

