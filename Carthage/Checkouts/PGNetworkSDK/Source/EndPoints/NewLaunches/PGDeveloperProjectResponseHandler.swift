//
//  PGDeveloperProjectResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 20/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGFeaturedProjectsHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGFeaturedProjects(bulldog: bulldog)
    }

}

struct PGFeaturedProjectListingsHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        output = PGFeaturedProjectListings(bulldog: bulldog)
    }
}

struct PGDeveloperProjectListHandler: PGResponse {
	var output: Any?
    init?(bulldog: Bulldog) {
        output = PGDeveloperProjectList(bulldog: bulldog)
    }
}


struct PGDeveloperProjectListItemHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        output = PGDeveloperProjectList(bulldog: bulldog)
    }
}


struct PGDeveloperProjectShortReviewHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGDeveloperProjectShortReview(bulldog: bulldog)
    }

}

struct PGDeveloperProjectDetailHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {
        output = PGDeveloperProjectDetail(bulldog: bulldog)
    }
}

struct PGDeveloperProjectLocationHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGDeveloperProjectLocation(bulldog: bulldog)
    }

}

struct PGDeveloperProjectReviewListHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGDeveloperProjectReviewList(bulldog: bulldog)
    }

}

struct PGDeveloperProjectReviewItemHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        output = PGDeveloperProjectReviewItem(bulldog: bulldog)
    }
}

// MARK: Initializers

extension PGFeaturedProjects {
    
    init?(bulldog: Bulldog) {
        if let items = bulldog.array("listings") {
            self.listings = items.flatMap { return PGFeaturedProjectListings(bulldog: Bulldog(json: $0)) }
        } else {
            self.listings = nil
        }
    }
    
}

extension PGFeaturedProjectListings {
    
    init?(bulldog: Bulldog) {
        id                      = bulldog.int("id")
        userId                  = bulldog.int("userId")
        title                   = bulldog.string("title")
        developmentName         = bulldog.string("developmentName")
        developerName           = bulldog.string("developerName")
        currency                = bulldog.string("price", "currency")
        priceValue              = bulldog.string("price", "value")
        pricePretty             = bulldog.string("price", "pretty")
        priceMin                = bulldog.string("price", "priceMin")
        priceMinValue           = bulldog.double("price", "priceMinValue")
        priceMax                = bulldog.string("price", "priceMax")
        priceMaxValue           = bulldog.double("price", "priceMaxValue")
        typeCode                = bulldog.string("price", "type", "code")
        typeText                = bulldog.string("price", "type", "text")
        priceType               = bulldog.string("priceType")
        propertyType            = bulldog.string("propertyType")
        propertyTypeGroup       = bulldog.string("propertyTypeGroup")
        listingType             = bulldog.string("listingType")
        currencyCode            = bulldog.string("currencyCode")
        countryCode             = bulldog.string("countryCode")
        salesName               = bulldog.string("contact", "salesName")
        salesPhone              = bulldog.string("contact", "salesPhone")
        salesEmail              = bulldog.string("contact", "salesEmail")
        salesWebsite            = bulldog.string("contact", "salesWebsite")
        phone                   = bulldog.string("contact", "phone")
        phoneExtension          = bulldog.string("contact", "extension")
        salesLogo               = bulldog.string("media", "salesLogo")
        developerLogo           = bulldog.string("media", "developerLogo")
        projectLogo             = bulldog.string("media", "projectLogo")
        mediaImageUrl           = bulldog.string("media", "imageUrl")
        mediaCoverImageUrl      = bulldog.string("media", "coverImageUrl")
        url                     = bulldog.string("url")
        relativeUrl             = bulldog.string("relativeUrl")
        reviewId                = bulldog.int("review", "reviewId")
        reviewTitle             = bulldog.string("review", "reviewTitle")
        reviewExcerpt           = bulldog.string("review", "reviewExcerpt")
        reviewCover             = bulldog.string("review", "reviewCover")
        reviewAuthor            = bulldog.string("review", "reviewAuthor")
        locationDistrictCode    = bulldog.string("location", "districtCode")
        locationDistrictText    = bulldog.string("location", "districtText")
        locationRegionCode      = bulldog.string("location", "regionCode")
        locationRegionText      = bulldog.string("location", "regionText")
        coverImages             = PGListingImages.getArrayOfImages(bulldog.dictionary("coverImage"))
        let lastUpdated         = bulldog.string("review", "lastUpdated", "date")
        reviewLastTimezoneType  = bulldog.int("review", "lastUpdated", "timezone_type")
        reviewLastTimezone      = bulldog.string("review", "lastUpdated", "timezone")
        reviewLastUpdatedDate   = PGFeaturedProjectListings.getDateFromString(lastUpdated, zone: reviewLastTimezone)
        let listedOnString      = bulldog.string("listedOn")
        listedOn                = PGFeaturedProjectListings.getDateFromString(listedOnString, zone: reviewLastTimezone)
        
    }
    
    public static func getDateFromString(_ string: String?, zone: String?) -> Date? {
        guard let string = string , string.characters.count > 0 else { return nil }
        guard let date   = PGDateHelper.toDateTime(string, format: "yyyy-MM-dd hh:mm:ss", timezone: zone) else { return nil }
        return date
    }
    
    public static func getStringDateFrom(_ date: Date, format: String) -> String {
        return PGDateHelper.toDateTime(date, format: format) as String
    }
    
}

extension PGDeveloperProjectList {
    
    init?(bulldog: Bulldog) {
        guard let count = bulldog.int("totalItems"),
            let page = bulldog.int("currentPage"),
            let totalPages = bulldog.int("totalPages"),
            let currentItems = bulldog.int("currentItems") else { return nil }
        self.totalItems = count
        self.totalPages = totalPages
        self.currentPage = page
        self.currentItems = currentItems
        if let listings = bulldog.array("listings") {
            self.listings = listings.flatMap { return PGDeveloperProjectListItem.init(bulldog: Bulldog(json: $0)) }
        } else {
            self.listings = nil
        }
    }
}

extension PGDeveloperProjectShortReview {
    
    init?(bulldog: Bulldog) {
        reviewId = bulldog.int("reviewId")
        reviewTitle = bulldog.string("reviewTitle")
        reviewExcerpt = bulldog.string("reviewExcerpt")
        reviewCover = bulldog.string("reviewCover")
        reviewAuthor = bulldog.string("reviewAuthor")
    }
}

extension PGDeveloperProjectLocation {
    public init?(bulldog: Bulldog) {
        guard let lat = bulldog.double("latitude"),
            let lng = bulldog.double("longitude"),
            PGLocationHelper.isValidCoordinate(lat, lng: lng)else {
                return nil
        }
        latitude = lat
        longitude = lng
        address1     = bulldog.string("address1")
        address2     = bulldog.string("address2")
        address3     = bulldog.string("address3")
        
        districtCode = bulldog.string("districtCode")
        districtText = bulldog.string("districtText")
        regionCode   = bulldog.string("regionCode")
        regionText   = bulldog.string("regionText")
        postalCode   = bulldog.string("postalCode")
        zoneCode     = bulldog.string("zoneCode")
        subzoneCode  = bulldog.string("subzoneCode")
        neighborhoods     = bulldog.string("neighborhoods")
        subNeighborhoods     = bulldog.string("subNeighborhoods")
        fullAddress  = bulldog.string("fullAddress")
        
    }
}

extension PGDeveloperProjectReviewList {
    
    init?(bulldog: Bulldog) {
        guard let totalItems = bulldog.int("totalItems"),
            let totalPages = bulldog.int("totalPages"),
            let currentPage = bulldog.int("page") else { return nil }
        self.totalItems = totalItems
        self.totalPages = totalPages
        self.currentPage = currentPage
        if let array = bulldog.array("posts") {
            posts = array.flatMap { return PGDeveloperProjectReviewItem.init(bulldog: Bulldog(json: $0)) }
        } else {
            posts = nil
        }
    }
    
}

extension PGDeveloperProjectReviewItem {
    
    init?(bulldog: Bulldog) {
        
        reviewId = bulldog.int("ID")
        listingId = bulldog.string("acf", "listing_id")
        advertiserId = bulldog.string("acf", "advertiser_id")
        title = bulldog.string("title")
        link = bulldog.string("link")
        featuredImage = bulldog.string("featured_image", "source")
        let firstname = bulldog.string("author", "first_name")
        let lastname = bulldog.string("author", "last_name")
        if let front = firstname {
            authorName = front
            if let back = lastname {
                authorName = "\(front) \(back)"
            }
        } else {
            authorName = nil
        }
        dateGmt = bulldog.string("date_gmt")
        excerpt = bulldog.string("excerpt")
        introductionHtml = bulldog.string("acf", "introduction")
        locationHtml = bulldog.string("acf", "location")
        projectHtml = bulldog.string("acf", "project")
        analysisHtml = bulldog.string("acf", "analysis")
        summaryHtml = bulldog.string("acf", "summary")
    }
}
