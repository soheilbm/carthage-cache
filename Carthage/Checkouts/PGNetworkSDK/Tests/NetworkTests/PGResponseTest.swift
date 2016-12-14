//
//  PGResponseTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 7/4/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGResponseTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_creation() {
        let object = ["key": "value"]
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0))
            let fJson = Bulldog(json: data)
            XCTAssertNotNil(fJson, "Expected to come here indicating successful creation")
        } catch let e {
            XCTAssertNil(e, "Not expected to have any catchable exceptions")
        }
    }
}
