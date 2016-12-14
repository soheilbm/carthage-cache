//
//  PGShortlistResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 4/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import Foundation

public struct PGShortlist {
    
    public let listingId: String
    public let name: String
    public let propertyId: String?
    public let bedCount: Int
    public let bathCount: Int

    public let typeCode: String?
    public let propertyTypeCode: String?
    public let propertyTypeGroup: String?
    public let latitude: Double?
    public let longitude: Double?
    public let price: String?
    public let floorArea: String?
    public let psf: String?
    public let streetName: String?
    public let agentName: String?
    public let agentMobile: String?
    public let imageUrl: String?
    public let priceType: String?
    public let accountType: String?
    public let featureCode: String?
    
    init?(bulldog: Bulldog) {
        guard let listingId = bulldog.int("listing_id"), let name = bulldog.string("property_name") else {
            return nil
        }
        self.listingId = String(describing: listingId)
        if let propertyId = bulldog.int("property_id") {
        	self.propertyId = String(describing: propertyId)
        } else {
            self.propertyId = nil
        }
        self.name = name
        self.bedCount = bulldog.int("bedrooms") ?? 0
        self.bathCount = bulldog.int("bathrooms") ?? 0
        
        typeCode = bulldog.string("type_code")
        propertyTypeGroup = bulldog.string("property_type_group")
        propertyTypeCode = bulldog.string("property_type_code")
        latitude = bulldog.double("latitude")
        longitude = bulldog.double("longitude")
        price = bulldog.string("price")
        floorArea = bulldog.string("floorarea")
        psf = bulldog.string("psf")
        streetName = bulldog.string("street_name")
        agentName = bulldog.string("agent_name")
        agentMobile = bulldog.string("agent_mobile")
        imageUrl = bulldog.string("image_url")
        priceType = bulldog.string("price_type")
        featureCode = bulldog.string("feature_code")
        accountType = bulldog.string("account_type")
    }
    
}
