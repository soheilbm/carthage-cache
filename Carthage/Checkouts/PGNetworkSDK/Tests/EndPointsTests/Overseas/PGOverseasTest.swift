//
//  PGOverseasTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 29/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGOverseasTest: XCTestCase {
    
    var sut_List: PGOverseasListRequest = PGOverseasListRequest()
    var sut_Detail: PGOverseasDetailRequest  = PGOverseasDetailRequest(id: "748592")
    var sut_CountryList: PGOverseasCountryListRequest = PGOverseasCountryListRequest()
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        
        sut_List = PGOverseasListRequest()
        sut_List.countryCode = "my"
        sut_List.typeCode = "CONDO"
        sut_List.topYear = "2017"
        sut_List.page = 1
        sut_List.limit = 5
        
        sut_Detail  = PGOverseasDetailRequest(id: "748592")
        sut_CountryList = PGOverseasCountryListRequest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Parameters
    func test_Parameters_List() {
        let expected: NSDictionary = ["targetCountry": "sg", "locale": "en", "countryCode": "my", "propertyType": "CONDO", "topYear": "2017", "page": 1, "limit": 5, "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_List.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters_Detail() {
        let expected: NSDictionary = ["targetCountry": "sg", "locale": "en", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_Detail.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters_CountryList() {
        let expected: NSDictionary = ["targetCountry": "sg", "locale": "en", "format": "verbose", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_CountryList.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Api Path
    func test_ApiPath_List() {
        let expected = "https://api.propertyguru.com/v2/overseas/lists"
        let actual = sut_List.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_Detail() {
        let expected = "https://api.propertyguru.com/v2/overseas/748592"
        let actual = sut_Detail.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_CountryList() {
        let expected = "https://api.propertyguru.com/v2/overseas/lists/count"
        let actual = sut_CountryList.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network + Parser
    func test_Network_List() {
        let expectation = self.expectation(description: "Network_Success")
        sut_List.networkManager = StubPGNetworkManager(expectedJson: SampleJson("NewLaunches.list"), expectedError: nil)
        sut_List.send(success: { response in
            guard let result = response as? PGDeveloperProjectList else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(result.listings)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_Network_CountryList() {
        let expectation = self.expectation(description: "Network_Success")
        sut_CountryList.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Overseas.countries"), expectedError: nil)
        sut_CountryList.send(success: { response in
            guard let result = response as? PGOverseasCountryList else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(result)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
