//
//  PGListingEnquiryTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 13/7/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGListingEnquiryTest: XCTestCase {
    var sut_Enquiry: PGListingEnquiryRequest = PGListingEnquiryRequest(agentId: "1", listingId: "2", name: "n", email: "e@e.com", phone: "3", message: "m", reason: "r", enquiryType: "t")
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com.sg"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut_Enquiry = PGListingEnquiryRequest(agentId: "1", listingId: "2", name: "n", email: "e@e.com", phone: "3", message: "m", reason: "r", enquiryType: "t")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testApiPath() {
        let expected = "https://api.propertyguru.com.sg/en/contact/add/1"
        let actual = sut_Enquiry.fullApiPath!
        XCTAssertEqual(expected, actual)
    }
    
    func testRequestType() {
        let expected: PGRequestHttpMethod = .post
        let actual = sut_Enquiry.httpMethod
        XCTAssertEqual(expected, actual)
    }

    func testParameters() {
        let expected: NSDictionary = ["listing_id": "2", "name": "n", "email": "e@e.com", "telephone": "3", "message": "m", "reason": "r", "enquiry_type": "t", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_Enquiry.requestParameters!)
        XCTAssertEqual(expected, actual)
    }
    
    func testNetworkSuccess() {
        let expectation = self.expectation(description: "Network_Success")
        sut_Enquiry.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Listings.enquiry_success"), expectedError: nil)
        sut_Enquiry.send(success: { response in
            guard let result = response as? PGListingEnquiryResponse else {
                XCTAssertFalse(true)
                return
            }
            XCTAssertTrue(result.success)
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testNetworkFail() {
        let expectation = self.expectation(description: "Network_Failure")
        sut_Enquiry.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Listings.enquiry_fail"), expectedError: nil)
        sut_Enquiry.send(success: { response in
            guard let result = response as? PGListingEnquiryResponse else {
                XCTAssertFalse(true)
                return
            }
            XCTAssertFalse(result.success)
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
