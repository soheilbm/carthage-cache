//
//  PGNetworkManagerTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 12/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

@testable import PGNetworkSDK
import XCTest

class PGNetworkManagerTest: XCTestCase {
    
    override func setUp() {
        PGNetworkSDK.sharedInstance.baseUrl = "http://www.example.com/"
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_NilApiPath() {
        PGNetworkSDK.sharedInstance.baseUrl = nil
        let mockRequest = MockNetworkRequest(path: nil)
        let networkManager = PGNetworkManager()
        let expectation = self.expectation(description: "Network0")
        networkManager.request(request: mockRequest, success: { _ in }, failure: { error in
            expectation.fulfill()
            XCTAssertEqual(error.message, "Invalid Request")
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_InvalidApiPathRequest() {
        PGNetworkSDK.sharedInstance.baseUrl = nil
        let mockRequest = MockNetworkRequest(path: "")
        let networkManager = PGNetworkManager()
        let expectation = self.expectation(description: "Network")
        networkManager.request(request: mockRequest, success: { _ in }, failure: { error in
            expectation.fulfill()
            XCTAssertEqual(error.message, "unsupported URL")
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // Not able to resolve, disabling for the time being
//    func test_SuccessResult() {
//        let mockRequest = MockNetworkRequest(path: "path")
//        let networkManager = PGNetworkManager()
//        let expectation = expectationWithDescription("Network1")
//        stub(uri("path"), builder: {request in
//            let response = NSHTTPURLResponse(URL: NSURL(), statusCode: 200, HTTPVersion: nil, headerFields: nil)!
//            let data: NSData = NSData()
//            return .Success(response, data)
//        })
//        
//        networkManager.request(request: mockRequest, success: { result in
//            expectation.fulfill()
//            XCTAssertNotNil(result)
//            }, failure: { error  in
//                print(error)
//        })
//        waitForExpectationsWithTimeout(3.0, handler: nil)
//    }
//    
//    func test_FailureResult() {
//        let mockRequest = MockNetworkRequest(path: "failure_path")
//        let networkManager = PGNetworkManager()
//        let expectation = expectationWithDescription("Network2")
//        
//        stub(uri("failure_path"), builder: {request in
//            let error: NSError = NSError(domain: "fake_url_error", code: 121, userInfo: nil)
//            return .Failure(error)
//        })
//        
//        networkManager.request(request: mockRequest, success: { _ in
//            }, failure: { error in
//                expectation.fulfill()
//                XCTAssertNotNil(error)
//        })
//        waitForExpectationsWithTimeout(3.0, handler: nil)
//    }
//    
//    func test_HttpMethodConversion_Get() {
//        let mockRequest = MockNetworkRequest(path: "", httpMethod: .get)
//        XCTAssertEqual(mockRequest.httpMethod.alamofireMethod(), Alamofire.Method.GET)
//    }
//    
//    func test_HttpMethodConversion_Post() {
//        let mockRequest = MockNetworkRequest(path: "", httpMethod: .post)
//        XCTAssertEqual(mockRequest.httpMethod.alamofireMethod(), Alamofire.Method.POST)
//    }
//    
//    func test_HttpMethodConversion_Put() {
//        let mockRequest = MockNetworkRequest(path: "", httpMethod: .put)
//        XCTAssertEqual(mockRequest.httpMethod.alamofireMethod(), Alamofire.Method.PUT)
//    }
}
