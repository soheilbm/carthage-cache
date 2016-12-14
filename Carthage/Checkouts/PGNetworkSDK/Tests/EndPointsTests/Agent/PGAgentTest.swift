//
//  PGAgentTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 25/10/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGAgentTest: XCTestCase {
    var sut: PGAgentRequest!
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        let key = "search/Wendy"
        sut = PGAgentRequest(agentType: key, otherParameters: [:])
        sut.baseUrl  = "https://api.propertyguru.com.sg"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: ApiPath
    func test_ApiPath_Agent() {
        let expected = "https://api.propertyguru.com.sg/en/agent/search/Wendy"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network Response Parser
    func test_Network_Agent() {
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Agent.result"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGAgentListResponse else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(result.list)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
