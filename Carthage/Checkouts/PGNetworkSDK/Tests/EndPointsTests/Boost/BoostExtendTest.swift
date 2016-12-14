//
//  BoostExtendTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 30/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class BoostExtendTest: XCTestCase {
    var sut: BoostExtendRequest!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = BoostExtendRequest(listingId: "12", tierType: 1, weeks: 1)
        sut.baseUrl = "https://api.propertyguru.com.sg"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com.sg/boost-bookings/extend"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters() {
        let expected: NSDictionary = ["listingId": "12", "tierType": 1, "duration": 1]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Boost.createSuccessful"), expectedError: nil)
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
            XCTAssertEqual(output.extendableWeeks, -1)
            XCTAssertEqual(output.startDate, 1480348800)
            XCTAssertEqual(output.endDate, 1480953599)
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func test_Network_failure_wrong_user() {
        let expectation = self.expectation(description: "Network_Failure1")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Boost.createErrorWrongUser"), expectedError: nil)
        sut.send(success: { response in
            guard let output = response as? PGNetworkError else {
                XCTAssertFalse(true)
                return
            }
            XCTAssertEqual(output.statusCode, 100008)
            XCTAssertEqual(output.message, "The user is not the owner of this listing.")
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func test_Network_failure_wrong_criteria() {
        let expectation = self.expectation(description: "Network_Failure2")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Boost.createErrorWrongCriteria"), expectedError: nil)
        sut.send(success: { response in
            guard let output = response as? PGNetworkError else {
                XCTAssertFalse(true)
                return
            }
            XCTAssertEqual(output.statusCode, 100005)
            XCTAssertEqual(output.message, "Your listing does not meet the criteria for Boost.")
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}

