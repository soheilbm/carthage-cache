//
//  PropertySearchRequestTest.swift
//  PGNetworkSDK
//
//  Created by Kenneth Poon on 8/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
import Foundation
@testable import PGNetworkSDK

class PropertySearchRequestTest: XCTestCase {
    
    
    func test_PropertySearchResponse_ok() {
        
        var sut = PropertySearchRequest(query: "Park")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Property.search"), expectedError: nil)
        let aExpectation = expectation(description: "Network_Success")
        sut.send(success:{ response in
            
            guard let result = response as? PropertySearchListResponse else {
                return
            }
            
            aExpectation.fulfill()
            
            XCTAssertEqual(result.list?[0].propertyId, 30)
            XCTAssertEqual(result.list?[0].propertyName, "Alessandrea")
            XCTAssertEqual(result.list?[0].typeGroup, "N")
            XCTAssertEqual(result.list?[0].typeCode, "APT")
            
            XCTAssertEqual(result.list?[0].streetName, "Alexandra Road")
            XCTAssertEqual(result.list?[0].streetNumber, "31")
            XCTAssertEqual(result.list?[0].estateCode, 0)
            XCTAssertNil(result.list?[0].regionCode)
            XCTAssertEqual(result.list?[0].districtCode, "D03")
            XCTAssertNil(result.list?[0].areaCode)
            XCTAssertEqual(result.list?[0].postalCode, "159967")

            XCTAssertEqual(result.list?[0].latitude, 1.290567)
            XCTAssertEqual(result.list?[0].longitude, 103.822622)
            XCTAssertEqual(result.list?[0].topYear, 2003)


            
            }, failure: { error in
                print("error: \(error.message)")
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    
}
