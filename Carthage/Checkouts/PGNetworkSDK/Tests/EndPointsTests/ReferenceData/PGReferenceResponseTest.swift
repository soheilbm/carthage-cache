//
//  PGReferenceResponseTest.swift
// PGNetworkSDK
//
//  Created by Soheil on 24/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGReferenceDataResponseTest: XCTestCase {
    
    var network: PGNetworkSDK {
        let network = PGNetworkSDK.sharedInstance
        network.baseUrl = "http://www.example.com"
        network.locale = "th"
        return network
    }
    
    override func setUp() {
        super.setUp()
        let _ = network
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testReferenceDataBaseResponse() {
////        let request = ReferenceBaseResponse(json: nil)
////        let expectedPath = "/th/referencedata/getReference"
////        XCTAssert(request.apiPath == expectedPath)
////        XCTAssert(request.baseUrl == network.baseUrl)
//        
//    }
    
    
}