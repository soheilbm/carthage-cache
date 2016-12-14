//
//  PGCondoListTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 2/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGCondoListTest: XCTestCase {
    var sut: PGCondoListRequest!
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = PGCondoListRequest()
        sut.latitude = 1.2
        sut.longitude = 103.2
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Parameters
    func test_Parameters_CondoList() {
        let expected: NSDictionary = ["typeGroup": "N", "isPrimaryBuilding": String(true), "limit": 50, "metadata": String(true), "pgDataSet": String(true),  "latitude": 1.2, "longitude": 103.2, "country": "sg", "lang": "en", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: ApiPath
    func test_ApiPath_CondoList() {
        let expected = "https://api.propertyguru.com/v1/properties"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network Response Parser
    func test_Network_CondoList() {
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Condo.list"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGCondoListResponse else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.currentPage, 1)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
