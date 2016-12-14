//
//  PriceTrendRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 15/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import Foundation

public struct PriceTrendSGRequest: PGApiRequest {
    
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PriceTrendSGResponseHandler.self
    var isAccessTokenRequired: Bool = true
    var httpMethod: PGRequestHttpMethod = .get
    var apiPath: String? = PGApiPath("PriceTrend", "singapore")

    let isSale: Bool
    let propertyType: String
    let districtCode: String
    let region: String
    
    public init(forSale sale: Bool, propertyType: String, districtCode: String, region: String = "all") {
        self.isSale = sale
        self.propertyType = propertyType
        self.districtCode = districtCode
        self.region = region
    }
    
    var parameters: [String: Any]? {
        return [
            "transactionType": isSale ? "sale" : "rent",
            "propertyType": propertyType,
            "districtCode": districtCode,
            "region": region,
            "metadata": 1
        ]
    }
    
}

public struct PriceTrendOthersRequest: PGApiRequest {
    
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PriceTrendOthersResponseHandler.self
    var isAccessTokenRequired: Bool = true
    var httpMethod: PGRequestHttpMethod = .get
    var apiPath: String? = PGApiPath("PriceTrend", "others")
    
    let propertyId: String
    let isListing: Bool
    
    public init(id: String, isListing: Bool = true) {
        self.propertyId = id
        self.isListing = isListing
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        if let value = PGNetworkSDK.sharedInstance.country { params["region"] = value  }
        if isListing { params["listingId"] = propertyId }
        else { params["propertyId"] = propertyId }
        return params
    }
    
}
