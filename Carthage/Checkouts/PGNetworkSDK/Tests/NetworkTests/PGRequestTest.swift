//
//  PGRequestTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 6/4/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGRequestTest: XCTestCase {
    var sut = MockNetworkRequest(path: "path", httpMethod: .get)
    let networkManager = PGNetworkManager()
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        sut.parameters = ["key": "value"]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ApiPath() {
        let expected = "path"
        XCTAssertEqual(expected, sut.fullApiPath)
    }
    
    func test_Parameters() {
        let expected = ["key": "value"]
        let actual = sut.requestParameters as! [String: String]
        XCTAssertEqual(expected, actual)
    }
    
//    func test_Request_Timeout() {
//        let mockRequest = MockNetworkRequest(path: "timeoutOnMe")
//        let expectation = expectationWithDescription("Network1")
//        stub(uri("timeoutOnMe"), builder: {request in
//            let error: NSError = NSError(domain: "timeout", code: -1001, userInfo: nil)
//            return .Failure(error)
//        })
//        networkManager.request(request: mockRequest, success: {_ in }, failure: { e in
//                expectation.fulfill()
//        })
//        waitForExpectationsWithTimeout(2.0, handler: nil)
//    }
    
    func test_Send() {
        let expectation = self.expectation(description: "Block_Success")
        networkManager.request(request: sut, success: { _ in
            expectation.fulfill()
            }, failure: { _ in
                expectation.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
    }
}
