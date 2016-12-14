//
//  BoostChargeTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 28/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class BoostChargeTest: XCTestCase {
    
    var sut: BoostChargeRequest!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = BoostChargeRequest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com/v1/boost-bookings/charges"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters() {
        let expected: NSDictionary = ["region": "sg", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Boost.bookingCharges"), expectedError: nil)
        sut.send(success: { response in
            guard let output = response as? [BoostChargeResponse] else {
                XCTAssertFalse(true)
                return
            }
            XCTAssertEqual(output.count, 4)
            let first = output[3]
            XCTAssertEqual(first.type, 3)
            XCTAssertEqual(first.isRent, false)
            XCTAssertEqual(first.bookingCharge, 35)
            XCTAssertEqual(first.repostCharge, 1)
            XCTAssertEqual(first.minListingQuality, 85)
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}
