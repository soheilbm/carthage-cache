//
//  PGNews.swift
//  Pods
//
//  Created by Soheil B.Marvasti on 11/3/16.
//
//

import Foundation

public struct ReferenceBaseResponse {
    public var stat: String?
    public var data = Dictionary<String, Array<ReferenceBaseItem>>()
}

public struct ReferencePropertyTypeCodeResponse {
    public var stat: String?
    public var propertyTypes: Array<PropertyTypeCode>?
}

public struct ReferenceInterestsResponse {
    public var stat: String?
    public var schools: Array<Interests>?
    public var mrtStations: Array<Interests>?
}

public struct ReferenceDistrictResponse {
    public var stat: String?
    public var districts: Array<District>?
}


public struct ReferenceGeographicAreaResponse {
    public var stat: String?
    public var areas: Array<GeographicArea>?
}

public struct ReferenceGeographicDistrictResponse {
    public var stat: String?
    public var districts: Array<GeographicDistrict>?
}


public struct ReferenceRegionCodeResponse {
    public var stat: String?
    public var regions: Array<Region>?
}

/// Models for Reference Datas

public struct ReferenceBaseItem {
    public let code: String?
    public let descriptionCode: String?
    public let sortOrder: Int?
}


public struct PropertyTypeCode {
    public let code: String
    public let descriptionCode: String
    public let groupCode: String
    public let sortOrder: Int
}

public struct Interests {
    public let name: String?
    public let lat: Double?
    public let lng: Double?
}

public struct District {
    public let code: String
    public let districtInfo: String
}

public struct GeographicArea  {
    public let code: String
    public let areaInfo: String
    public let parent: String
}

public struct GeographicDistrict  {
    public let code: String
    public let districtInfo: String
    public let parent: String
}

public struct Region {
    public let code: String
    public let regionInfo: String
}
