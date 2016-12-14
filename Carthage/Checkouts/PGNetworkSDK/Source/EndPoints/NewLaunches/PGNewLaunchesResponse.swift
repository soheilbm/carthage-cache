//
//  NewLaunchesResponse.swift
//  Pods
//
//  Created by Suraj Pathak on 23/3/16.
//
//

import Foundation

public struct PGNewLaunchesConstant {
    public var propertyTypesResendial: [(String, String)]? = []
    public var propertyTypesCommercial: [(String, String)]? = []
    public var propertyTenures: [(String, String)]? = []
    public var propertySearchPrices: [PGPropertySearchPrice]? = []
    
    init(bulldog: Bulldog) {
        let dict1 = bulldog.dictionary("residentialDeveloperPropertyTypes")
        if let dict = dict1 {
            for (key, value) in dict {
                propertyTypesResendial?.append(key, String(describing: value))
            }
        }
        
        let dict2 = bulldog.dictionary("commercialDeveloperPropertyTypes")
        if let dict = dict2 {
            for (key, value) in dict {
                propertyTypesCommercial?.append(key, String(describing: value))
            }
        }
        
        let dict3 = bulldog.dictionary("developerPropertyTenure")
        if let dict = dict3 {
            for (key, value) in dict {
                propertyTenures?.append(key, String(describing: value))
            }
        }
        
        let dict4 = bulldog.dictionary("developerPropertySearchPrices")
        if let dict = dict4 {
            let sortedKeys = dict.keys//.sorted(by: { $1 > $0 })
            for key in sortedKeys {
                if let prices = bulldog.rawJson("developerPropertySearchPrices", key),
                    let searchPrice = PGPropertySearchPrice.init(bulldog: Bulldog(json: prices)) {
                    propertySearchPrices?.append(searchPrice)
                    
                }
            }
        }
    }
}

public struct PGPropertySearchPrice {
    public var minPrice: Int = 1
    public var maxPrice: Int? = 1
    public let caption: String
    
    init?(bulldog: Bulldog) {
        guard let minPrice = bulldog.int("minPrice"),
            let caption = bulldog.string("caption") else { return nil }
        self.minPrice = minPrice
        self.caption = caption
        self.maxPrice = bulldog.int("maxPrice")
    }
    
}

public struct PGNewLaunchesEnquiryResponse {
    public var success: Bool
    public var message: String?
    
    init?(bulldog: Bulldog) {
        success = bulldog.bool("success")
        message = bulldog.string("message")
    }
    
}
