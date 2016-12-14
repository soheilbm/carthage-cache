//
//  PriceTrendResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 15/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import Foundation

struct PriceTrendSGResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let meta = bulldog.dictionary("districtMeta"), let data = bulldog.array("districtRooms") else { return nil }
        guard let from = meta["timeStart"] as? Double,
            let to = meta["timeEnd"] as? Double,
            let district = meta["districtDescription"] as? String,
            let propertyType = meta["propertyType"] as? String,
            let districtCode = meta["districtCode"] as? String,
            let tranxType = meta["transactionType"] as? String,
        	let transactionType = TranxType(rawValue: tranxType),
        	let years = meta["yearList"] as? [Double] else { return nil }
        let fromDate = Date(timeIntervalSince1970: from/1000)
        let toDate = Date(timeIntervalSince1970: to/1000)
        
        var trend = PriceTrend(from: fromDate, to: toDate, propertyType: propertyType, districts: district, districtCode: districtCode, transactionType: transactionType, years: years, bedTypes: [], priceVolume: [])
        
        var bedTypes: Set<String> = []
        var priceVolumeList: Set<PriceVolume> = []
        
        for dataItem in data {
            let itemBulldog = Bulldog(json: dataItem)
            if let vol = itemBulldog.int("numTrans"), let avgPsf = itemBulldog.double("avgPsf"), let volumeTrendListRaw = itemBulldog.array("volumeTrend"), let priceIndexListRaw = itemBulldog.array("priceIndex") {
                let bedType = itemBulldog.string("bedroomsType") ?? "All"
                var priceVolume = PriceVolume(volume: vol, avgPsf: avgPsf, bedType: bedType, volumeTrend: [], priceIndex: [])

                bedTypes.insert(bedType)
                var volumeList: [VolumeTrend] = []
                var priceIndexList: [PriceIndex] = []
                
                // Volume trends
                for volTrendItem in volumeTrendListRaw {
                    if let item = volTrendItem as? [Double] {
                        let date = item[0]
                        let amount = item[1]
                        let volTrendObj = VolumeTrend(time: Date(timeIntervalSince1970: date/1000), volume: Int(amount))
                        volumeList.append(volTrendObj)
                    }
                }
                
                // PriceIndex Trends
                for priceIndexItem in priceIndexListRaw {
                    if let item = priceIndexItem as? [Double] {
                        let date = item[0]
                        let amount = item[1] * avgPsf
                        let priceIndexObj = PriceIndex(time: Date(timeIntervalSince1970: date/1000), index: amount)
                        priceIndexList.append(priceIndexObj)
                    }
                }
                
                priceVolume.volumeTrend = volumeList
                priceVolume.priceIndex = priceIndexList
                priceVolumeList.insert(priceVolume)
            }
        }
        
        trend.bedTypes = bedTypes
        trend.priceVolume = priceVolumeList
        output = trend
    }
    
}

struct PriceTrendOthersResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let stat = bulldog.string("stat"), stat == "ok" else { return nil }
        output = true
    }
    
}
