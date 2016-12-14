//
//  PGComparationTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 12/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGNetworkHelperTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_AppendParameters_Nil_And_Nil() {
        let actual = PGNetworkHelper.appendParameters([nil, nil])
        XCTAssertNil(actual)
    }
    
    func test_AppendParameters_Nil_And_NotNil() {
        let params = ["key": "value"]
        let actual = PGNetworkHelper.appendParameters([nil, params]) as! [String: String]
        XCTAssertEqual(params, actual)
    }
    
    func test_AppendParameters_NotNil_And_NotNil() {
        let params1 = ["key": "value"]
        let params2 = ["key1": "value1"]
        let expected = ["key": "value", "key1": "value1"]
        let actual = PGNetworkHelper.appendParameters([params1, params2]) as! [String: String]
        XCTAssertEqual(expected, actual)
    }
    
    func test_ObjectsEqual_SingleObject_False() {
        let object1 = NSObject()
        let actual = PGComparation.areObjectsEqual([object1])
        XCTAssertFalse(actual)
    }
    func test_ObjectsEqual_TwoObjects_Unequal() {
        let object1 = NSDictionary(dictionary: ["key": "value"])
        let object2 = NSDictionary(dictionary: ["key": "value", "key1": "value1"])
        let actual = PGComparation.areObjectsEqual([object1, object2])
        XCTAssertFalse(actual)
    }
    func test_ObjectsEqual_TwoObjects_Equal() {
        let object1 = NSDictionary(dictionary: ["key": "value", "key1": "value1"])
        let object2 = NSDictionary(dictionary: ["key": "value", "key1": "value1"])
        let actual = PGComparation.areObjectsEqual([object1, object2])
        XCTAssertTrue(actual)
    }
    func test_ObjectsEqual_ThreeObjects_Unequal() {
        let object1 = NSDictionary(dictionary: ["key": "value", "key1": "value1"])
        let object2 = NSDictionary(dictionary: ["key": "value"])
        let object3 = NSDictionary(dictionary: ["key": "value", "key1": "value1"])
        let actual = PGComparation.areObjectsEqual([object1, object2, object3])
        XCTAssertFalse(actual)
    }
    func test_ObjectsEqual_ThreeObjects_Equal() {
        let object1 = NSDictionary(dictionary: ["key": "value", "key1": "value1"])
        let object2 = NSDictionary(dictionary: ["key": "value", "key1": "value1"])
        let object3 = NSDictionary(dictionary: ["key": "value", "key1": "value1"])
        let actual = PGComparation.areObjectsEqual([object1, object2, object3])
        XCTAssertTrue(actual)
    }
    
    func test_location_helper_ok() {
        let lat = 1.9123
        let lng = 103.123
        
        XCTAssertTrue(PGLocationHelper.isValidCoordinate(lat, lng: lng))
    }
    
    func test_location_helper_fail() {
        let lat = -102.9123
        let lng = 103.123
        
        XCTAssertFalse(PGLocationHelper.isValidCoordinate(lat, lng: lng))
    }
    
    func test_location_helper_fail_for_zero() {
        let lat:Double = 0
        let lng:Double = 0
        
        XCTAssertFalse(PGLocationHelper.isValidCoordinate(lat, lng: lng))
    }
}
