//
//  CondoTransactionResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 19/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGCondoTransactionResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        guard let totalItems = bulldog.int("metadata", "totalItems"),
            let currentPage = bulldog.int("metadata", "currentPage"),
            let totalPage = bulldog.int("metadata", "totalPages") else { return nil }
        var tranx = PGCondoTransactionResponse(count: totalItems, page: currentPage, totalPages: totalPage)
        if let array = bulldog.array("response") {
            tranx.items = array.flatMap { PGCondoTransactionItemResponseHandler(bulldog: Bulldog(json: $0))?.output as? PGCondoTransactionItemResponse }
        }
        output = tranx
    }
    
}

struct PGCondoTransactionItemResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        let contractDate = bulldog.string("contractDate") ?? ""
        let floorArea = bulldog.string("areaFloorSqft") ?? ""
        let streetAddress = bulldog.string("streetName1") ?? ""
        let streetNumber = bulldog.string("streetNumber") ?? ""
        let unitNumber = bulldog.string("unitNumber") ?? ""
        let psf = bulldog.string("psfFloor") ?? ""
        let psm = bulldog.string("psmFloor") ?? ""
        let typeOfSale = bulldog.string("saleType") ?? ""
        let bedroom = bulldog.string("bedrooms") ?? ""
        let priceSales = bulldog.string("price")
        let priceRent = bulldog.string("monthlyRent")
        let price = priceSales ?? priceRent ?? ""
        output = PGCondoTransactionItemResponse(contractDate: contractDate, floorArea: floorArea, streetAddress: streetAddress, streetNumber: streetNumber, unitNumber: unitNumber, price: price, psf: psf, psm: psm, typeOfSale: typeOfSale, bedroom: bedroom)
        
    }
    
}
