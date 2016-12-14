//
//  BoostActiveTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 28/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class BoostActiveTest: XCTestCase {
    var sut: BoostActiveRequest!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = BoostActiveRequest(listingId: "123")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com/v1/boost-bookings/booked"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters() {
        let expected: NSDictionary = ["listingIds": "123", "region": "sg", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Boost.activeBoosts"), expectedError: nil)
        sut.send(success: { response in
            guard let output = response as? BoostResponse else {
                XCTAssertFalse(true)
                return
            }
            XCTAssertEqual(output.id, 7)
            XCTAssertEqual(output.listingId, 15226648)
            XCTAssertEqual(output.repostCharge, 1)
            XCTAssertEqual(output.bookingCharge, 35)
            XCTAssertEqual(output.tierType, 3)
            XCTAssertEqual(output.status, "DELAY")
            XCTAssertEqual(output.extendableWeeks, 3)
            XCTAssertEqual(output.startDate, 1480348800)
            XCTAssertEqual(output.endDate, 1480953599)
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func test_Network_failure() {
        let expectation = self.expectation(description: "Network_Failure1")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Boost.activeBoostEmpty"), expectedError: nil)
        sut.send(success: { _ in
            }, failure: { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}
