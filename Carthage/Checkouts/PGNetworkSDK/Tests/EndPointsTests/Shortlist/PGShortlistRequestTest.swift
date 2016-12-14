//
//  PGShortlistRequestTest.swift
//  PGSDK
//
//  Created by Soheil on 15/5/16.
//  Copyright © 2016 Soheil. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGShortlistGetRequestTest: XCTestCase {
    var sut: PGShortlistGetRequest = PGShortlistGetRequest(baseUrl: "https://api.staging.propertyguru.com.sg")
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.staging.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ShortlistApiPath() {
        let expected = "https://api.staging.propertyguru.com.sg/shortlist/get"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ShortlistGet_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Shortlist.get"), expectedError: nil)
        sut.send(success: { response in
            guard let cat = response as? [PGShortlist] else {
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

class PGShortlistAddRequestTest: XCTestCase {
    var sut: PGShortlistAddRequest = PGShortlistAddRequest(baseUrl: "https://api.staging.propertyguru.com.sg",id:"1234")
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.staging.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ShortlistApiPath() {
        let expected = "https://api.staging.propertyguru.com.sg/shortlist/add/1234"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ShortlistAdd() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Shortlist.updateOk"), expectedError: nil)
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

class PGShortlistRemoveRequestTest: XCTestCase {
    var sut: PGShortlistRemoveRequest = PGShortlistRemoveRequest(baseUrl: "https://api.staging.propertyguru.com.sg",id:"1234")
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.staging.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ShortlistApiPath() {
        let expected = "https://api.staging.propertyguru.com.sg/shortlist/remove/1234"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ShortlistRemove() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Shortlist.updateOk"), expectedError: nil)
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
