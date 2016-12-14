//
//  ListingDetailTest.swift
// PGNetworkSDK
//
//  Created by Soheil on 27/4/16.
//  Copyright © 2016 Soheil. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class SimilarListingDetailTest: XCTestCase {
    
    var sut_Detail: PGSimilarListingRequest {
        return PGSimilarListingRequest("1234", limit: 5)
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
    func test_ListingDetailApiPath() {
        let expected = "https://api.staging.propertyguru.com.sg/v1/listings"
        let actual = sut_Detail.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ListingDetail_Parameters() {
        let expected: NSDictionary = [ "locale": "en", "region": "sg","similar_listing_id":"1234","limit":"5","access_token":"token"]
        let actual = NSDictionary(dictionary: sut_Detail.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_ListingDetail_ParametersExtra() {
        let expected: NSDictionary = [ "locale": "en", "region": "sg","_isTracked":"1","device_id":"12345","similar_listing_id":"1234","limit":"4","access_token":"token"]
        let request = PGSimilarListingRequest("1234",limit:4,deviceId: "12345",isTracked: true)
        let actual = NSDictionary(dictionary: request.requestParameters!)
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
    
    func test_ListingDetailResponse_fail() {
        var sut = PGListingDetailRequest("9885260",deviceId: "12345",isTracked: true)
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Listings.fail_listing_detail"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success:{ response in
            // should fail
            }, failure: { error in
                expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
