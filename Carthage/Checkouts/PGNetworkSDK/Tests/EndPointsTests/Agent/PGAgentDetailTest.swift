//
//  PGAgentDetailTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 25/10/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGAgentDetailTest: XCTestCase {
    var sut: PGAgentDetailRequest!
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        let agentId = "27513"
        sut = PGAgentDetailRequest(agentId: agentId)
        sut.baseUrl  = "https://api.propertyguru.com.sg"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: ApiPath
    func test_ApiPath_AgentDetail() {
        let expected = "https://api.propertyguru.com.sg/en/agent/view/27513"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network Response Parser
    func test_Network_AgentDetail() {
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Agent.detail"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGAgentDetailResponse else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.agentId, "27513")
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}

