//
//  PGCondoDirectoryTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 2/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGCondoListingsTest: XCTestCase {
    var sut: PGCondoListingsRequest!
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = PGCondoListingsRequest(id: "ID", agentId: nil, type: .rent, page: 1, limit: 50)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Parameters
    func test_Parameters_CondoListings() {
        let expected: NSDictionary = ["property_id": "ID", "region": "sg", "locale": "en", "listing_type": "rent", "limit": 50, "page": 1, "access_token": "token", "include_mobile_condospotlight_listing": String(true)]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: ApiPath
    func test_ApiPath_CondoListings() {
        let expected = "https://api.propertyguru.com/v1/listings"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network Response Parser
    func test_Network_CondoListings() {
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Condo.listings"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGSimilarListing else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(result.listings)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
