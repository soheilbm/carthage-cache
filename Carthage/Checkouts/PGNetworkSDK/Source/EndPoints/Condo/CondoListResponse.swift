//
//  CondoListResponse.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 2/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGCondoListResponse {
    public var totalItems: Int
    public var currentPage: Int
    public var totalPages: Int
    public var condos: [PGCondoDetailResponse]?
    
    init(count: Int, page: Int, totalPages: Int) {
        self.totalItems = count
        self.currentPage = page
        self.totalPages = totalPages
    }

}
