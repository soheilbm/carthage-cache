//
//  PGRequestTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 12/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGApiRequestTest: XCTestCase {
    var sut = MockApiNetworkRequest(path: "")
    
    struct TestResponseHandler: PGResponse {
        var output: Any?
        init?(bulldog: Bulldog) {
            
        }
    }
    
    override func setUp() {
        super.setUp()
        sut.baseUrl = "baseurl"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestFullApiPath_valid() {
        sut.apiPath = "/path/"
        let expected = "baseurl/path/"
        let actual = sut.fullApiPath
        XCTAssertEqual(expected, actual)
    }
    
    func testRequestFullApiPath_inValid() {
        sut.apiPath = nil
        XCTAssertNil(sut.fullApiPath)
    }
    
    func testParameters_withoutToken_withParam() {
        sut.isAccessTokenRequired = false
        sut.parameters = ["key": "value"]
        let expected = ["key": "value"]
        let actual = sut.requestParameters as! [String: String]
        XCTAssertEqual(actual, expected)
    }
    
    func testParameters_withoutToken_withoutParam() {
        sut.isAccessTokenRequired = false
        sut.parameters = nil
        XCTAssertNil(sut.requestParameters)
    }
    
    func testParameters_withToken_withParam() {
        sut.isAccessTokenRequired = true
        sut.parameters = ["key": "value"]
        let expected = ["key": "value", "access_token": "token"]
        let actual = sut.requestParameters as! [String: String]
        XCTAssertEqual(actual, expected)
    }
    
    func testParameters_withToken_withoutParam() {
        sut.isAccessTokenRequired = true
        sut.parameters = nil
        let expected = ["access_token": "token"]
        let actual = sut.requestParameters as! [String: String]
        XCTAssertEqual(actual, expected)
    }
    
    func testSend_HandlerClass_ServerError() {
        sut.responseHandler = TestResponseHandler.self
        let expectedError = PGNetworkError(code: -999, message: "999")
        sut.networkManager = StubPGNetworkManager(expectedJson: nil, expectedError: expectedError)
        let expectation = self.expectation(description: "Block_Success")
        sut.send(success: {_ in}, failure: { error in
            XCTAssertEqual(error, expectedError)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
