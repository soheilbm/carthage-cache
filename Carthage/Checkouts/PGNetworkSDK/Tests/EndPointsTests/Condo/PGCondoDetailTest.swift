//
//  PGCondoTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 2/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGCondoDetailTest: XCTestCase {
    var sut: PGCondoDetailRequest!
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = PGCondoDetailRequest(condoId: "PG_1295")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Parameters
    func test_Parameters_CondoDetail() {
        let expected: NSDictionary = ["pgDataSet": true, "country": "sg", "lang": "en", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: ApiPath
    func test_ApiPath_CondoDetail() {
        let expected = "https://api.propertyguru.com/v1/properties/PG_1295"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network Response Parser
    func test_Network_CondoDetail() {
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Condo.detail"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGCondoDetailResponse else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(result.propertyId)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
