//
//  CondoTransactionResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 18/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoTransactionResponse {
    public var totalItems: Int
    public var currentPage: Int
    public var totalPages: Int
    public var items: [PGCondoTransactionItemResponse]?
    
    init(count: Int, page: Int, totalPages: Int) {
        self.totalItems = count
        self.currentPage = page
        self.totalPages = totalPages
    }

}

public struct PGCondoTransactionItemResponse {
    public let contractDate: String
    public let floorArea: String
    public let streetAddress: String
    public let streetNumber: String
    public let unitNumber: String
    public let price: String
    public let psf: String
    public let psm: String
    public let typeOfSale: String
    public let bedroom: String
}
