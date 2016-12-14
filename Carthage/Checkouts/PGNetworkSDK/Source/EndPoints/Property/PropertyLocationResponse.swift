//
//  PropertyLocationResponse.swift
//  PGNetworkSDK
//
//  Created by Kenneth Poon on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PropertyLocationListResponse: Equatable{
    public var list: [PropertyLocationResponse]?
    
}

public func ==(lhs: PropertyLocationListResponse, rhs: PropertyLocationListResponse) -> Bool {
    guard let lhsList = lhs.list, let rhsList = rhs.list else {
        return false
    }
    for (index, lhsComponent) in lhsList.enumerated() {
        
        guard rhsList.indices.contains(index) else {
            return false
        }
        
        guard lhsComponent == rhsList[index] else {
            return false
        }
        
    }
    return true
}


public struct PropertyLocationResponse: Equatable{
    
    public var locationId: Int?
    public var propertyId: Int?
    public var propertyName: String?
    public var typeGroup: String?
    public var typeCode: String?
    
    public var streetNumber: String?
    public var streetName: String?
    public var estateCode: Int?
    public var regionCode: String?
    public var districtCode: String?
    public var areaCode: String?
    public var postalCode: String?
    
    
    public var latitude: Double?
    public var longitude: Double?
    
    
}


public func ==(lhs: PropertyLocationResponse, rhs: PropertyLocationResponse) -> Bool {
    guard lhs.locationId == rhs.locationId else {
        return false
    }
    guard lhs.propertyId == rhs.propertyId else {
        return false
    }
    guard lhs.propertyName == rhs.propertyName else {
        return false
    }
    guard lhs.typeCode == rhs.typeCode else {
        return false
    }
    guard lhs.typeGroup == rhs.typeGroup else {
        return false
    }
    guard lhs.streetName == rhs.streetName else {
        return false
    }
    guard lhs.streetNumber == rhs.streetNumber else {
        return false
    }
    guard lhs.estateCode == rhs.estateCode else {
        return false
    }
    guard lhs.regionCode == rhs.regionCode else {
        return false
    }
    guard lhs.districtCode == rhs.districtCode else {
        return false
    }
    guard lhs.areaCode == rhs.areaCode else {
        return false
    }
    guard lhs.postalCode == rhs.postalCode else {
        return false
    }
    guard lhs.latitude == rhs.latitude else {
        return false
    }
    guard lhs.longitude == rhs.longitude else {
        return false
    }
    
    return true
}

