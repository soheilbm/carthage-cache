//
//  CondoDetailResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 2/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoDetailResponse {
    
    public let propertyId: Int
    public var typeGroup: String?
    public var typeCode: String?

    public let propertyName: String
    public let streetNumber: String?
    public let streetName: String?

    
    public let latitude: Double
    public let longitude: Double
    
    public var fullAddress: String?
    
    public let regionCode: String?
    public let districtCode: String?
    public let areaCode: String?

    
    public var country: String?
    public var countryCode: String?
    
    public var averagePsf: Double?
    public var typeCodeFullname: String?
    public var tenureFullName: String?
    public var developerName: String?
    public var topYear: String?
    public var totalUnits: Int?
    public var propertyDescription: String?
    
    public var facilities: [String]?
    
    public var coverImage: String?
    public var listImageUrl: [PGDeveloperMedia]?
    public var videos: [PGDeveloperMedia]
    public var virtualTours: [PGDeveloperMedia]
    public var sharingUrl: String?
    
    public var hasReview: Bool = false
    public var hasVideo: Bool = false
    public var hasVirtualTour: Bool = false
    
    init?(bulldog: Bulldog) {
        let pgPropertyId = bulldog.int("propertyIdPg")
        let validPropertyId = bulldog.int("propertyId")
        let propertyId = pgPropertyId ?? validPropertyId
        if propertyId == nil { return nil }
        
        guard let propertyName = bulldog.string("propertyName"), let latitude = bulldog.double("latitude"), let longitude = bulldog.double("longitude") else { return nil }
        
        self.propertyId = propertyId!
        self.propertyName = propertyName
        
        self.typeGroup = bulldog.string("typeGroup")
        self.typeCode = bulldog.string("typeCode")
        
        self.streetNumber = bulldog.string("streetNumber")
        self.streetName = bulldog.string("streetName1")

        self.regionCode = bulldog.string("regionCode")
        self.districtCode = bulldog.string("districtCode")
        self.areaCode = bulldog.string("areaCode")

        
        self.latitude = latitude
        self.longitude = longitude
        
        fullAddress = bulldog.string("fullAddress")
        country = bulldog.string("countryName")
        countryCode = bulldog.string("countryCode")
        
        averagePsf = bulldog.double("statistics", "last18months", "transactionPsf", "avg")
        typeCodeFullname = bulldog.string("typeCodeFullName")
        tenureFullName = bulldog.string("tenureFullName")
        developerName = bulldog.string("developerName")
        if let top = bulldog.int("completedYear") {
            topYear = String(describing: top)
        } else {
            topYear = nil
        }
        
        totalUnits = bulldog.int("totalUnits")
        propertyDescription = bulldog.string("description")
        
        facilities = bulldog.array("facilityNames") as? [String]
        
        coverImage = bulldog.string("coverImage")
        if let imageMedia = bulldog.array("images") {
            listImageUrl = imageMedia.flatMap { item in
                guard let condoMedia = CondoDetailMediaHandler(bulldog: Bulldog(json: item))?.output as? CondoDetailMedia else { return nil }
                return PGDeveloperMedia(url: condoMedia.url, fileType: condoMedia.fileType, caption: condoMedia.caption)
            }
        }
        videos = []
        virtualTours = []
        sharingUrl = bulldog.string("links", "propertyguru")
    }
    
}

struct CondoDetailMedia {
    
    let fileType: String
    let url: String
    let caption: String?
    
}
