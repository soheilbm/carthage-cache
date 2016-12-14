//
//  PGAlertTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 7/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGAlertGetTest: XCTestCase {
    var sut: PGGetAlertRequest!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com.sg"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = PGGetAlertRequest()
        sut.baseUrl = "https://api.propertyguru.com.sg"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com.sg/en/listing/getSaveSearch"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Alert.get"), expectedError: nil)
        sut.send(success: { response in
            guard let cat = response as? [PGAlertResponse] else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(cat.count > 1)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}

class PGAlertAddTest: XCTestCase {
    var sut: PGCreateAlertRequest!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com.sg"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = PGCreateAlertRequest(options: ["area_code": "A01", "free_text": "32"])
        sut.baseUrl = "https://api.propertyguru.com.sg"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com.sg/en/listing/saveSearchListing"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_parameters() {
        let expected: [String: String] = ["area_code": "A01", "free_text": "32", "access_token": "token"]
        let actual = sut.requestParameters as! [String: String]
        XCTAssertEqual(actual, expected)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Alert.update"), expectedError: nil)
        sut.send(success: { response in
            guard let cat = response as? Bool else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertTrue(cat)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}

class PGAlertDeleteTest: XCTestCase {
    var sut: PGDeleteAlertRequest!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = PGDeleteAlertRequest(alertId: "3232")
        sut.baseUrl = "https://api.propertyguru.com.sg"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com.sg/en/listing/deleteAlert/3232"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Alert.update"), expectedError: nil)
        sut.send(success: { response in
            guard let cat = response as? Bool else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertTrue(cat)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}
