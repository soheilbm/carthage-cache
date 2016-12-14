//
// PGSDKConfigurationTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 30/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGSDKConfigurationTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testKeyPathShortCutMethod_Default() {
        XCTAssertNotNil(PGApiPath("UITest", "Default"))
    }
    
    func testKeyPath_EmptyKeypath() {
        XCTAssertNil(PGApiPath(""))
    }
    
    func testKeyPath_NonStringKeypath() {
        XCTAssertNil(PGApiPath("UITest", "NonString"))
    }

    func testKeyPath_Multicountry_ValidCountry() {
        let expected = "singapore"
        PGNetworkSDK.sharedInstance.country = "sg"
        let actual = PGNetworkApiPathHandler.sharedInstance.valueForKeyPath(["UITest", "MultiCountry"])
        XCTAssertEqual(expected, actual)
    }
    
    func testKeyPath_Multicountry_InvalidCountry() {
        PGNetworkSDK.sharedInstance.country = "xx"
        let actual = PGNetworkApiPathHandler.sharedInstance.valueForKeyPath(["UITest", "MultiCountry"])
        XCTAssertNil(actual)
    }
}
