//
//  PGCalculatorTest.swift
//  PGSDK
//
//  Created by Soheil on 15/5/16.
//  Copyright © 2016 Soheil. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGCalculatorTest: XCTestCase {
    
    var sut_Detail: PGCalculatorRequest {
        return PGCalculatorRequest("19353236", location: "top", language: "en", source: "app")
    }
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.staging.propertyguru.com.sg"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_CalcukatirApiPath() {
        let expected = "https://api.staging.propertyguru.com.sg/v1/calculator/mortgage"
        let actual = sut_Detail.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_CalculatorApiPath_Parameter() {
        let expected: NSDictionary = [ "language": "en", "region": "sg","country":"sg","source":"app","location":"top","access_token":"token"]
        let actual = NSDictionary(dictionary: sut_Detail.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_ListingDetailResponse_ok() {
        var sut = PGSimilarListingRequest("1234",limit:4,deviceId: "12345",isTracked: true)
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Listings.similar_listing"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success:{ response in
            guard let result = response as? PGSimilarListing else {
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.total, 385)
            XCTAssertEqual(result.page, 1)
            XCTAssertEqual(result.limit, 4)
            XCTAssertEqual(result.totalPages, 97)
            XCTAssertEqual(result.currency, "RM")
            XCTAssertEqual(result.listings?.count, 4)
            XCTAssertEqual(result.listings?.first?.id, 22251515)
            XCTAssertEqual(result.listings?.first?.statusCode, "ACT")
            XCTAssertEqual(result.listings?.first?.sourceCode, "AGENCY")
            XCTAssertEqual(result.listings?.first?.typeCode, "SALE")
            XCTAssertEqual(result.listings?.first?.typeText, "For Sale")
            XCTAssertEqual(result.listings?.first?.typeText, "For Sale")
            
            }, failure: { error in
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
