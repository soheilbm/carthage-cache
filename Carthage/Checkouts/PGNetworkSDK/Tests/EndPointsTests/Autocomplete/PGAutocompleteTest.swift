//
//  PGAutocompleteTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 10/6/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGAutocompleteTest: XCTestCase {
    var sut = PGAutocompleteGeneralRequest(keyword: "Hello", objectType: "DISTRICT")
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = PGAutocompleteGeneralRequest(keyword: "Hello", objectType: "DISTRICT")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Parameters
    func test_Parameters_Autocomplete_General() {
        let expected: NSDictionary = ["limit": 20, "objectType": "DISTRICT", "region": "sg", "locale": "en", "query": "Hello", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: ApiPath
    func test_ApiPath_Autocomplete_General() {
        let expected = "https://api.propertyguru.com/v1/autocomplete"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network Response Parser
    func test_Network_Autocomplete_General() {
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Autocomplete.general"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGAutocompleteResultResponse else {
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
