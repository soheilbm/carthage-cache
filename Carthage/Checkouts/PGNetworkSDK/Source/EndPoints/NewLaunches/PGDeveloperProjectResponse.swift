//
//  PGDeveloperProjectResponse.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 30/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGFeaturedProjects {
    public let listings: [PGFeaturedProjectListings]?
}

public struct PGFeaturedProjectListings {
    public let id: Int?
    public let userId: Int?
    public let title: String?
    public let developmentName: String?
    public let developerName: String?
    public let currency: String?
    public let priceValue: String?
    public let pricePretty: String?
    public let priceMin: String?
    public let priceMinValue: Double?
    public let priceMax: String?
    public let priceMaxValue: Double?
    public let typeCode: String?
    public let typeText: String?
    public let priceType: String?
    public let propertyType: String?
    public let propertyTypeGroup: String?
    public let listingType: String?
    public let currencyCode: String?
    public let countryCode: String?
    public let salesName: String?
    public let salesPhone: String?
    public let salesEmail: String?
    public let salesWebsite: String?
    public let phone: String?
    public let phoneExtension: String?
    public let salesLogo: String?
    public let developerLogo: String?
    public let projectLogo: String?
    public let mediaImageUrl: String?
    public let mediaCoverImageUrl: String?
    public let url: String?
    public let relativeUrl: String?
    public let reviewId: Int?
    public let reviewTitle: String?
    public let reviewExcerpt: String?
    public let reviewCover: String?
    public let reviewAuthor: String?
    public let reviewLastUpdatedDate: Date?
    public let reviewLastTimezoneType: Int?
    public let reviewLastTimezone: String?
    public let listedOn: Date?
    public let locationDistrictCode: String?
    public let locationDistrictText: String?
    public let locationRegionCode: String?
    public let locationRegionText: String?
    public let coverImages: [PGListingImages]?
    
}

public struct PGDeveloperProjectList {
    public var totalItems: Int?
    public var totalPages: Int?
    public var currentPage: Int?
    public var currentItems: Int?
    public var listings: [PGDeveloperProjectListItem]?
}

public struct PGDeveloperProjectListItem {
    public let propertyId: Int
    public let advertiserId: Int
    public let propertyName: String
    public var propertyType: String?
    public var topYear: Int?
    public var title: String?
    public var developerName: String?
    public var coverImageUrl: String?
    public var developerImageUrl: String?
    
    public var countryCode: String?
    public var countryName: String?
    public var districtCode: String?
    public var regionCode: String?
    public var districtName: String?
    public var regionName: String?
    public var fullAddress: String?
    
    public var latitude: Double?
    public var longitude: Double?
    public var currencyCode: String?
    
    public var price: String?
    public var priceType: String?
    
    public var hasReview: Bool = false
    public var hasVirtualTour: Bool = false
    public var shortReview: PGDeveloperProjectShortReview?
    
    init?(bulldog: Bulldog) {
        guard let _id = bulldog.int("id"), let _advId = bulldog.int("userId"), let _title = bulldog.string("title"), let _name = bulldog.string("developmentName") else { return nil }
        
        propertyId = _id
        advertiserId = _advId
        title = _title
        propertyName = _name
        
        propertyType = bulldog.string("propertyType")
        developerName = bulldog.string("developerName")
        topYear = bulldog.int("topYear")
        
        coverImageUrl = coverImageUrlFromJson(bulldog)
        developerImageUrl = bulldog.string("developerImages", "developerLogo")
        
        countryCode = bulldog.string("countryCode")
        countryName = bulldog.string("countryName")
        fullAddress = bulldog.string("location", "fullAddress")
        
        
        districtCode = bulldog.string("location", "districtCode")
        regionCode = bulldog.string("location", "regionCode")
        districtName = bulldog.string("location", "districtText")
        regionName = bulldog.string("location", "regionText")
        latitude = bulldog.double("location", "latitude")
        longitude = bulldog.double("location", "longitude")
        
        currencyCode = bulldog.string("currencyCode")
        price = bulldog.string("price")
        priceType = bulldog.string("priceType")
        hasVirtualTour = bulldog.bool("media", "virtualTour")
        if let review = bulldog.rawJson("review") {
            shortReview = PGDeveloperProjectShortReview(bulldog: Bulldog(json: review))
        }
        if let _ = shortReview?.reviewId {
            hasReview = true
        } else {
            shortReview = nil
            hasReview = false
        }
    }
    
    fileprivate func coverImageUrlFromJson(_ bulldog: Bulldog ) -> String? {
        let priorities = ["V550", "V800", "V350", "V160B", "V150", "V75B"]
        for priority in priorities {
            if let url = bulldog.string("coverImage", "\(priority)") {
                return url
            }
        }
        return nil
    }
    
}

public struct PGDeveloperProjectShortReview {
    public var reviewId: Int?
    public var reviewTitle: String?
    public var reviewExcerpt: String?
    public var reviewCover: String?
    public var reviewAuthor: String?
}

public struct PGDeveloperProjectDetail {
    public let propertyId: Int
    public var listingTypeCode: String?
    
    public var price: String?
    public var priceType: String?
    public var title: String?
    public var developmentName: String?
    public var listedOnDate: Date?
    public var endDate: Date?
    public var topYear: String?
    public var propertyTypeCode: String?
    public var developerName: String?
    
    public var countryCode: String?
    public let location: PGDeveloperProjectLocation?
    
    public let floorarea: Int?
    public let landarea: Int?
    
    public var tenure: String?
    public var projectDescription: String?
    
    public var keyFeatures: [String]?
    public var nearbyAmenity: [String]?
    public var facilities: [String]?

    public var unitsAndPrices: String?
    public var currencyCode: String?
    
    public var listImageUrl: [PGDeveloperMedia]?
    public var videos: [PGDeveloperMedia]
    public var virtualTours: [PGDeveloperMedia]
    public var sharingUrl: String?
    
    public var advertiserId: Int?
    public var advertiserName: String?
    public let companyName: String?
    public var advertiserEmail: String?
    public var advertiserPhoneNumber: String?
    public var advertiserPhoneNumberToCall: String?
    public var advertiserImageUrl: String?
    
    public var psm: Double?
    public var psf: Double?
    public var bedrooms: Int?
    
    public var hasReview: Bool = false
    public var hasVideo: Bool = false
    public var hasVirtualTour: Bool = false
    
    public var shortReview: PGDeveloperProjectShortReview?
    
    public var customFields: PGDeveloperCustomField
    
    init?(bulldog: Bulldog) {
        guard let _id = bulldog.int("id") else { return nil }
        propertyId = _id
        listingTypeCode = bulldog.string("listingType")
        price = bulldog.string("price")
        priceType = bulldog.string("priceType")
        unitsAndPrices = bulldog.string("prices")
        title = bulldog.string("title")
        developmentName = bulldog.string("developmentName")
        if let loc = bulldog.rawJson("location"),
            let location = PGDeveloperProjectLocation(bulldog: Bulldog(json: loc)) {
            self.location = location
        } else {
            self.location = nil
        }
        
        floorarea = bulldog.int("floorarea")
        landarea = bulldog.int("landarea")
        
        propertyTypeCode = bulldog.string("propertyType")
        developerName = bulldog.string("developerName")
        tenure = bulldog.string("tenure")
        countryCode = bulldog.string("countryCode")
        projectDescription = bulldog.string("description")
        
        let featureStr = bulldog.string("keyFeatures")
        let facilitiesStr = bulldog.string("facilities")
        let amenityStr = bulldog.string("nearbyAmenities")
        
        // key features, facilities and amenities will be updated to be array in new version
        if featureStr == nil && facilitiesStr == nil && amenityStr == nil {
            keyFeatures = bulldog.array("keyFeatures") as? [String]
            facilities = bulldog.array("facilities") as? [String]
            nearbyAmenity  = bulldog.array("nearbyAmenities") as? [String]
        } else {
            if let value = featureStr { keyFeatures = [value] }
            if let value = facilitiesStr { facilities = [value] }
            if let value = amenityStr { nearbyAmenity = [value] }
        }
        
        listImageUrl = PGDeveloperProjectDetail.getListImagesFromJson(bulldog)
        videos = PGDeveloperProjectDetail.getMedia("OUMOV", from: bulldog)
        virtualTours = PGDeveloperProjectDetail.getMedia("OTOUR", from: bulldog)
        hasVideo = videos.count > 0
        hasVirtualTour = virtualTours.count > 0
        
        sharingUrl = bulldog.string("url")
        advertiserId = bulldog.int("userId")
        advertiserName = bulldog.string("contact", "salesName")
        companyName = bulldog.string("contact", "salesName")
        advertiserEmail = bulldog.string("companyName")
        advertiserPhoneNumber = bulldog.string("contact", "salesPhone")
        advertiserPhoneNumberToCall = bulldog.string("contact", "phone")
        advertiserImageUrl = bulldog.string("developerImages", "salesLogo")
        currencyCode = bulldog.string("currencyCode")
        psm = bulldog.double("psm")
        psf = bulldog.double("psf")
        bedrooms = bulldog.int("bedrooms")
        // Date
        let listedDateString = bulldog.string("listedOn")
        if let dateStr = listedDateString {
            listedOnDate = PGDateHelper.toDateTime(dateStr, format: "yyyy-MM-dd hh:mm:ss", timezone: nil)
        }
        
        let endDateString = bulldog.string("endDate")
        if let dateStr = endDateString {
            endDate = PGDateHelper.toDateTime(dateStr, format: "yyyy-MM-dd hh:mm:ss", timezone: nil)
        }
        
        let topYearInt = bulldog.int("topYear")
        if let tYear = topYearInt {
            topYear = "\(tYear)"
        }
        
        if let review = bulldog.rawJson("review") {
            shortReview = PGDeveloperProjectShortReview(bulldog: Bulldog(json: review))
        }
        if let _ = shortReview?.reviewId {
            hasReview = true
        } else {
            shortReview = nil
            hasReview = false
        }
        
        // Custom fields
        if let customField = bulldog.dictionary("contactCustomFields") {
            var nric = false
            var addr = false
            for (key, _) in customField {
                if key == "NRIC"  { nric = true }
                if key == "HOMEADDR" { addr = true }
            }
            self.customFields = PGDeveloperCustomField(nric: nric, address: addr)
        } else {
            self.customFields = PGDeveloperCustomField()
        }
    }
    
    static func getListImagesFromJson(_ bulldog: Bulldog) -> [PGDeveloperMedia] {
        return getMedia("OUPHO", from: bulldog).filter { URL(string: $0.url) != nil }
    }
    
    static func getMedia(_ type: String, from bulldog: Bulldog) -> [PGDeveloperMedia] {
        var imageUrlArray: [PGDeveloperMedia] = []
        if let photoContainer = bulldog.dictionary("media", type, "V550") {
            for (_, value) in photoContainer {
                let bulldog = Bulldog(json: value)
                if let imageUrl = bulldog.string("fullUrl"),
                    let fileType = bulldog.string("fileType") {
                    imageUrlArray.append(PGDeveloperMedia(url: imageUrl, fileType: fileType, caption: bulldog.string("caption")))
                }
            }
        }
        
        return imageUrlArray
        
    }
    
}

public struct PGDeveloperCustomField {
    public let nric: Bool
    public let address: Bool
    
    init(nric: Bool = false, address: Bool = false) {
        self.nric = nric
        self.address = address
    }

}

public struct PGDeveloperMedia {
    public let url: String
    public let fileType: String
    public let caption: String?
    
    public init(url: String, fileType: String, caption: String? = nil) {
        self.url = url
        self.fileType = fileType
        self.caption = caption
    }

}

public struct PGDeveloperProjectLocation {
    public let address1: String?
    public let address2: String?
    public let address3: String?
    public let districtCode: String?
    public let districtText: String?
    public let regionCode: String?
    public let regionText: String?
    public let postalCode: String?
    public let zoneCode: String?
    public let subzoneCode: String?
    public let neighborhoods: String?
    public let subNeighborhoods: String?
    public let fullAddress: String?
    public let latitude: Double?
    public let longitude: Double?
}


public struct PGDeveloperProjectReviewList {
    public var totalItems: Int?
    public var totalPages: Int?
    public var currentPage: Int?
    public var posts: [PGDeveloperProjectReviewItem]?
}

public struct PGDeveloperProjectReviewItem {
    public var reviewId: Int?
    public var listingId: String?
    public var advertiserId: String?
    public var title: String?
    public var link: String?
    public var featuredImage: String?
    public var authorName: String?
    public var dateGmt: String?
    public var excerpt: String?
    public var introductionHtml: String?
    public var locationHtml: String?
    public var projectHtml: String?
    public var analysisHtml: String?
    public var summaryHtml: String?
}
