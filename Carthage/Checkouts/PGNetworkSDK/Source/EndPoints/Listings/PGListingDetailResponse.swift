//
//  PGListingDetailResponse.swift
// PGNetworkSDK
//
//  Created by Soheil on 27/4/16.
//  Copyright © 2016 Soheil. All rights reserved.
//

import Foundation

public struct PGSimilarListing {
    public let total: Double?
    public let page: Double?
    public let limit: Double?
    public let totalPages: Double?
    public let currency: String?
    public let listings: Array<PGListingDetail>?
}

public struct PGListingLocation {
    public let latitude: Double?
    public let longitude: Double?
    public let regionCode: String?
    public let regionText: String?
    public let regionSlug: String?
    public let districtCode: String?
    public let districtText: String?
    public let districtSlug: String?
    public let areaCode: String?
    public let areaText: String?
    public let areaSlug: String?
    public let fullAddress: String?
    public let postalCode: String?
    public let streetId: Int?
}

public enum PGEmbededMediaType {
    case html
    case mov
}

public struct PGListingEmbededMedia {
    public let path: URL?
    public let content: String?
    public let caption: String?
    public let thumbnail: URL?
    public let type: PGEmbededMediaType
}

public struct PGListingMedia {
    public let coverImages: [PGListingImages]?
    public let agentImagePath: String?
    public let agencyImage: [PGListingImages]?
    public let listingImages: [PGListingImages]?
    public let propertyImages: [PGListingImages]?
    public let listingFloorplans: [PGListingImages]?
    public let listingVideos: [PGListingEmbededMedia]?
    public let listingVirtualTours: [PGListingEmbededMedia]?
    
}

public struct PGListingAgent {
    public let agentId: Int
    public let name: String?
    public let license: String?
    public let mobile: String?
    public let mobileText: String?
    public let phone: String?
    public let phoneText: String?
    public let jobTitle: String?
    public let showProfile: Bool
    public let website: String?
    
    public let agencyId: Int?
    public let agencyName: String?
    public let Agencylicense: String?
    
}


public struct PGListingDetailDate {
    public let timezone: String?
    public let firstPostedDate: Date?
    public let firstPostedDateUnit: Double?
    public let lastPostedDate: Date?
    public let lastPostedDateUnit: Double?
    public let expiryDate: Date?
    public let expiryDateUnit: Double?
}

public struct PGListingDetailFeature {
    public let code: String
    public let codeDescription: String
}

public struct PGListingDetail {
    public let id: Int
    public let statusCode: String?
    public let sourceCode: String?
    public let typeCode: String?
    public let typeText: String?
    public let subTypeCode: String?
    public let leaseTermCode: String?
    public let leaseTermText: String?
    public let featureCode: String?
    public let accountTypeCode: String?
    public let isPremiumAccount: Bool
    public let isFeaturedListing: Bool
    public let isPropertySpecialistListing: Bool
    public let isMobilePropertySpotlightListing: Bool
    public let isTransactorListing: Bool
    public let hasFloorplans: Bool
    public let hasStream: Bool
    public let localizedTitle: String?
    public let localizedDescription: String?
    public let price: Double?
    public let priceText: String?
    public let pricePerAreaValue: Double?
    public let pricePerAreaUnit: String?
    public let pricePerAreaReference: String?
    public let priceTypeCode: String?
    public let priceTypeText: String?
    public let currency: String?
    public let bedroomsValue: Int?
    public let bedroomsText: String?
    public let bathroomsValue: Int?
    public let bathroomsText: String?
    public let extraRoomValue: Int?
    public let extraRoomText: String?
    public let floorAreaUnit: String?
    public let floorAreaValue: Double?
    public let floorAreaText: String?
    public let landAreaUnit: String?
    public let landAreaValue: Double?
    public let landAreaText: String?
    public let pricePerFloorAreaUnit: String?
    public let pricePerFloorAreaValue: Double?
    public let pricePerFloorAreaText: String?
    public let pricePerLandAreaUnit: String?
    public let pricePerLandAreaValue: Double?
    public let pricePerLandAreaText: String?
    public let propertyId: Int?
    public let propertyTempId: Int?
    public let propertyStatusCode: String?
    public let propertyTypeCode: String?
    public let propertyTypeText: String?
    public let propertyTypeGroup: String?
    public let propertyTenureCode: String?
    public let propertyTenureText: String?
    public let propertyUnitId: Int?
    public let hdbEstateCode: String?
    public let hdbEstateText: String?
    public let topMonth: Int?
    public var topYear: Int?
    public let floors: Int?
    public let developer: String?
    public let listingQualityScore: Int?
    public let furnishingCode: String?
    public let furnishingText: String?
    public let apiURL: String?
    public let mobileURL: String?
    public let desktopURL: String?
    public let electricitySupply: Int?
    public let listingMedia: PGListingMedia?
    public let listingLocation: PGListingLocation?
    public let listingAgent: PGListingAgent?
    public let listingDates: PGListingDetailDate?
    public let listingFacilities: [PGListingDetailFeature]?
    public let listingAmenities: [PGListingDetailFeature]?

}
