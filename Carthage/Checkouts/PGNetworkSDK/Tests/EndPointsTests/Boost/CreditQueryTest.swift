//
//  CreditQueryTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 28/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class CreditQueryTest: XCTestCase {
    
    var sut: CreditQueryRequest!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = CreditQueryRequest()
        sut.baseUrl = "https://api.propertyguru.com.sg"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com.sg/extranet_listing/countAllowedNewListings"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters() {
        XCTAssertNil(sut.requestParameters)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Boost.queryCredit"), expectedError: nil)
        sut.send(success: { response in
            guard let output = response as? CreditQueryResponse else {
                XCTAssertFalse(true)
                return
            }
            XCTAssertEqual(output.newListingLeft, 80)
            XCTAssertEqual(output.availableActiveSlots, 80)
            XCTAssertEqual(output.availableCredits, 400)
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}
