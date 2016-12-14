//
//  PriceTrend.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 14/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import Foundation

public enum TranxType: String {
    case sale, rent
}

public struct PriceTrend {
    
    public let from: Date
    public let to: Date
    public let propertyType: String
    public let districts: String
    public let districtCode: String
    public let transactionType: TranxType
    public let years: [Double]
    
    // mutable values
    public var bedTypes: Set<String>
    public var priceVolume: Set<PriceVolume>
    
}

public struct PriceVolume: Hashable {
    public let volume: Int
    public let avgPsf: Double
    public let bedType: String
    
    // mutable values
    public var volumeTrend: [VolumeTrend]
    public var priceIndex: [PriceIndex]
    
    public var hashValue: Int { return bedType.hashValue }
    public static func ==(lhs: PriceVolume, rhs: PriceVolume) -> Bool {
        return lhs.bedType == rhs.bedType && lhs.avgPsf == rhs.avgPsf && lhs.volumeTrend.count == rhs.volumeTrend.count && lhs.priceIndex.count == rhs.priceIndex.count
    }

}

public struct VolumeTrend {
    public let time: Date
    public let volume: Int
}

public struct PriceIndex {
    public let time: Date
    public let index: Double
}

extension PriceTrend {
    
    private func date(beforeYears year: Double) -> Date {
        return Date().addingTimeInterval(-year*365*24*60*60)
    }
    
    private func isInRange(_ yearRange: Double) -> Bool {
        let rangeStartDate = date(beforeYears: yearRange)
        return to.compare(rangeStartDate) == .orderedDescending
    }
    
    public func filtered(bedType type: String, yearRange: Double) -> PriceVolume? {
        guard isInRange(yearRange) else { return nil }
        guard var priceValBed = priceVolume.first(where: { pv -> Bool in
            return pv.bedType == type
        }) else { return nil }
        
        let startDate = date(beforeYears: yearRange)
        // trax date must be after or on this start date ~~ startDate must not be smaller than tranx date
        let validVolumeTranx = priceValBed.volumeTrend.filter { startDate.compare($0.time) != .orderedDescending }
        let validPriceIndex = priceValBed.priceIndex.filter { startDate.compare($0.time) != .orderedDescending }
        
        priceValBed.volumeTrend = validVolumeTranx
        priceValBed.priceIndex = validPriceIndex
        
        return priceValBed
    }
    
}
