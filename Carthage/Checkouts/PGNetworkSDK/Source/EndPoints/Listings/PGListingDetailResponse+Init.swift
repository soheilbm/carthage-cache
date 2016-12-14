//
//  PGListingDetailResponse+Init.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 20/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

extension PGListingLocation {
    
    init?(bulldog: Bulldog) {
        if let lat = bulldog.double("location", "latitude"),
        let lng = bulldog.double("location", "longitude"),
        PGLocationHelper.isValidCoordinate(lat, lng: lng) {
            latitude = lat
            longitude = lng
        }else{
            latitude = nil
            longitude = nil
        }
        
        regionCode   = bulldog.string("location", "regionCode")
        regionText   = bulldog.string("location", "regionText")
        regionSlug   = bulldog.string("location", "regionSlug")
        districtCode = bulldog.string("location", "districtCode")
        districtText = bulldog.string("location", "districtText")
        districtSlug = bulldog.string("location", "districtSlug")
        areaCode     = bulldog.string("location", "areaCode")
        areaText     = bulldog.string("location", "areaText")
        areaSlug     = bulldog.string("location", "areaSlug")
        fullAddress  = bulldog.string("location", "fullAddress")
        postalCode   = bulldog.string("location", "postalCode")
        streetId     = bulldog.int("location", "streetId")
    }

}

extension PGListingEmbededMedia {
    
    init?(bulldog: Bulldog) {
        if let content = bulldog.string("embed_html") {
            self.content = content
            self.path = nil
            type = .html
        } else if let path = bulldog.string("file"), let url = URL(string: path) {
            self.path = url
            self.content = nil
            type = .mov
        }else{
            return nil
        }
        
        caption   = bulldog.string("caption")
        if let thumb = bulldog.string("thumb"), let thumbnail = URL(string: thumb) {
            self.thumbnail = thumbnail
        } else{
            thumbnail = nil
        }
        
    }
    
}

extension PGListingMedia {
    
    init?(bulldog: Bulldog) {
        agentImagePath = bulldog.string("media", "agent")
        coverImages = PGListingImages.getArrayOfImages(bulldog.dictionary("media", "cover"))
        listingImages = PGListingImages.getArrayOfImages(bulldog.array("media", "listing"))
        propertyImages = PGListingImages.getArrayOfImages(bulldog.array("media", "property"))
        listingFloorplans = PGListingImages.getArrayOfImages(bulldog.array("media", "listingFloorplans"))
        agencyImage = PGListingImages.getArrayOfImages(bulldog.array("media", "agencyLogo"))
        
        if let items = bulldog.array("media", "listingVideos") {
            listingVideos = items.flatMap { return PGListingEmbededMedia(bulldog: Bulldog(json: $0)) }
        }	else {
            listingVideos = nil
        }
        
        if let items = bulldog.array("media", "listingVirtualTours") {
            listingVirtualTours = items.flatMap { return PGListingEmbededMedia(bulldog: Bulldog(json: $0)) }
        } else {
            listingVirtualTours = nil
        }
    }
}

extension PGListingAgent {
    init?(bulldog: Bulldog) {
        guard let _id = bulldog.int("agent", "id") else { return nil }
        agentId     = _id
        name        = bulldog.string("agent", "name")
        mobile      = bulldog.string("agent", "mobile")
        mobileText  = bulldog.string("agent", "mobilePretty")
        phone       = bulldog.string("agent", "phone")
        phoneText   = bulldog.string("agent", "phonePretty")
        jobTitle    = bulldog.string("agent", "jobTitle")
        showProfile = bulldog.bool("agent", "showProfile")
        website     = bulldog.string("agent", "website")
        agencyId    = bulldog.int("agency", "id")
        agencyName  = bulldog.string("agency", "name")
        
        license = bulldog.string("agent", "licenseNumber")
        Agencylicense = bulldog.string("agency", "ceaLicenseNumber")
        
        
    }
}


extension PGListingDetailDate {
    
    init?(bulldog: Bulldog) {
        timezone            = bulldog.string("dates", "timezone")
        firstPostedDateUnit = bulldog.double("dates", "firstPosted", "unix")
        firstPostedDate     = PGListingDetailDate.getDateFromUnix(firstPostedDateUnit, zone: timezone)
        
        lastPostedDateUnit  = bulldog.double("dates", "lastPosted", "unix")
        lastPostedDate      = PGListingDetailDate.getDateFromUnix(lastPostedDateUnit, zone: timezone)
        
        expiryDateUnit      = bulldog.double("dates", "expiry", "unix")
        expiryDate          = PGListingDetailDate.getDateFromUnix(expiryDateUnit, zone: timezone)
        
        
    }
    
    static func getDateFromUnix(_ unix: Double?, zone: String?) -> Date? {
        guard let unix = unix , unix > 0 else { return nil }
        return Date(timeIntervalSince1970: unix)
    }
    
    static func getDateFromString(_ string: String?, zone: String?) -> Date? {
        guard let string = string , string.characters.count > 0 else { return nil }
        guard let date   = PGDateHelper.toDateTime(string, format: "yyyy-MM-dd hh:mm:ss", timezone: zone) else { return nil }
        return date
    }
    
    static func getStringDateFrom(_ date: Date, format: String) -> String {
        return PGDateHelper.toDateTime(date, format: format) as String
    }
    
}

extension PGListingDetail {
    
    init?(bulldog: Bulldog ) {
        guard let listingId = bulldog.int("id") else { return nil }
        id                               = listingId
        statusCode                       = bulldog.string("statusCode")
        sourceCode                       = bulldog.string("sourceCode")
        typeCode                         = bulldog.string("typeCode")
        typeText                         = bulldog.string("typeText")
        subTypeCode                      = bulldog.string("subTypeCode")
        leaseTermCode                    = bulldog.string("leaseTermCode")
        leaseTermText                    = bulldog.string("leaseTermText")
        featureCode                      = bulldog.string("featureCode")
        accountTypeCode                  = bulldog.string("accountTypeCode")
        isPremiumAccount                 = bulldog.bool("isPremiumAccount")
        isFeaturedListing                = bulldog.bool("isFeaturedListing")
        isPropertySpecialistListing      = bulldog.bool("isPropertySpecialistListing")
        isMobilePropertySpotlightListing = bulldog.bool("isMobilePropertySpotlightListing")
        isTransactorListing              = bulldog.bool("isTransactorListing")
        hasFloorplans                    = bulldog.bool("hasFloorplans")
        hasStream                        = bulldog.bool("hasStream")
        localizedTitle                   = bulldog.string("localizedTitle")
        localizedDescription             = bulldog.string("localizedDescription")
        price                            = bulldog.double("price", "value")
        priceText                        = bulldog.string("price", "pretty")
        pricePerAreaValue                = bulldog.double("price", "pricePerArea", "value")
        pricePerAreaUnit                 = bulldog.string("price", "pricePerArea", "unit")
        pricePerAreaReference            = bulldog.string("price", "pricePerArea", "reference")
        priceTypeCode                    = bulldog.string("price", "type", "code")
        priceTypeText                    = bulldog.string("price", "type", "text")
        currency                         = bulldog.string("price", "currency")
        bedroomsValue                    = bulldog.int("sizes", "bedrooms", "value")
        bedroomsText                     = bulldog.string("sizes", "bedrooms", "text")
        bathroomsValue                   = bulldog.int("sizes", "bathrooms", "value")
        bathroomsText                    = bulldog.string("sizes", "bathrooms", "text")
        extraRoomValue                   = bulldog.int("sizes", "extrarooms", "value")
        extraRoomText                    = bulldog.string("sizes", "extrarooms", "text")
        floorAreaUnit                    = bulldog.string("sizes", "floorArea", 0, "unit")
        floorAreaValue                   = bulldog.double("sizes", "floorArea", 0, "value")
        floorAreaText                    = bulldog.string("sizes", "floorArea", 0, "text")
        landAreaUnit                     = bulldog.string("sizes", "landArea", 0, "text")
        landAreaValue                    = bulldog.double("sizes", "landArea", 0, "value")
        landAreaText                     = bulldog.string("sizes", "landArea", 0, "text")
        pricePerFloorAreaUnit            = bulldog.string("pricePerArea", "floorArea", 0, "unit")
        pricePerFloorAreaValue           = bulldog.double("pricePerArea", "floorArea", 0, "value")
        pricePerFloorAreaText            = bulldog.string("pricePerArea", "floorArea", 0, "text")
        pricePerLandAreaUnit             = bulldog.string("pricePerArea", "landArea", 0, "unit")
        pricePerLandAreaValue            = bulldog.double("pricePerArea", "landArea", 0, "value")
        pricePerLandAreaText             = bulldog.string("pricePerArea", "landArea", 0, "text")
        propertyId                       = bulldog.int("property", "id")
        propertyTempId                   = bulldog.int("property", "temporaryId")
        propertyUnitId                   = bulldog.int("propertyUnit", "id")
        propertyStatusCode               = bulldog.string("property", "statusCode")
        propertyTypeCode                 = bulldog.string("property", "typeCode")
        propertyTypeText                 = bulldog.string("property", "typeText")
        propertyTypeGroup                = bulldog.string("property", "typeGroup")
        propertyTenureCode               = bulldog.string("property", "tenureCode")
        propertyTenureText               = bulldog.string("property", "tenureText")
        listingQualityScore              = bulldog.int("qualityScore")
        hdbEstateCode                    = bulldog.string("location", "hdbEstateCode")
        hdbEstateText                    = bulldog.string("location", "hdbEstateText")
        topMonth                         = bulldog.int("property", "topMonth")
        topYear                          = bulldog.int("property", "topYear")
        floors                           = bulldog.int("property", "floors")
        developer                        = bulldog.string("property", "developer")
        furnishingCode                   = bulldog.string("propertyUnit", "furnishingCode")
        furnishingText                   = bulldog.string("propertyUnit", "furnishingText")
        apiURL                           = bulldog.string("urls", "listing", "api")
        mobileURL                        = bulldog.string("urls", "listing", "mobile")
        desktopURL                       = bulldog.string("urls", "listing", "desktop")
        electricitySupply                = bulldog.int("propertyUnit", "electricitySupply")
        listingMedia                     = PGListingMedia(bulldog: bulldog)
        listingAgent                     = PGListingAgent(bulldog: bulldog)
        listingLocation                  = PGListingLocation(bulldog: bulldog)
        listingDates                     = PGListingDetailDate(bulldog: bulldog)
        
        if let items = bulldog.array("propertyUnit", "features") {
            listingFacilities = items.flatMap { return PGListingDetailFeatureHandler(bulldog: Bulldog(json: $0))?.output as? PGListingDetailFeature }
        } else {
            listingFacilities = nil
        }
        
        if let items = bulldog.array("property", "amenities") {
            listingAmenities = items.flatMap { return PGListingDetailFeatureHandler(bulldog: Bulldog(json: $0))?.output as? PGListingDetailFeature }
        } else {
            listingAmenities = nil
        }
    }
    
}
