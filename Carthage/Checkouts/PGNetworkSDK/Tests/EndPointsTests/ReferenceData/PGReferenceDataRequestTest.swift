//
//  PGReferenceDataRequest.swift
// PGNetworkSDK
//
//  Created by Soheil on 23/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGReferenceDataRequestTest: XCTestCase {
    
    var network: PGNetworkSDK = PGNetworkSDK.sharedInstance
    
    override func setUp() {
        super.setUp()
        let _ = network
        PGNetworkSDK.sharedInstance.baseUrl = "baseurl"
        PGNetworkSDK.sharedInstance.locale = "th"
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testReferenceDataBaseWithoutUrl() {
        let request = ReferenceBaseRequest(baseUrl: nil, locale: nil)
        let expectedPath = "/referencedata/getReference"
        XCTAssert(request.apiPath! == expectedPath)
        XCTAssert(request.baseUrl! == network.baseUrl!)
    }
    
    func testReferenceDataBaseWithoutLocale() {
        network.locale = nil
        let request = ReferenceBaseRequest(baseUrl: nil, locale: nil)
        let expectedPath = "/referencedata/getReference"
        XCTAssert(request.apiPath! == expectedPath)
        XCTAssert(request.baseUrl! == network.baseUrl)
        network.locale = nil
        print(request.fullApiPath!)
        print("\(network.baseUrl!)\(expectedPath)")
        XCTAssertEqual(request.fullApiPath!, "\(network.baseUrl!)\(expectedPath)")
    }
    
    func testReferenceDataBase() {
        let givenBaseUrl = "http://api.propertyguru.com.sg"
        let request = ReferenceBaseRequest(baseUrl: givenBaseUrl, locale: nil)
        let expectedPath = "/referencedata/getReference"
        XCTAssert(request.apiPath == expectedPath)
        XCTAssert(request.baseUrl == givenBaseUrl)
        XCTAssert(request.responseHandler == ReferenceBaseResponseHandler.self)
    }
    
    func testReferenceDataInterests() {
        let givenBaseUrl = "http://api.propertyguru.com.sg"
        let request = ReferenceInterestsRequest(baseUrl: givenBaseUrl, locale: nil)
        let expectedPath = "/referencedata/getInterests"
        XCTAssert(request.apiPath == expectedPath)
        XCTAssert(request.baseUrl == givenBaseUrl)
        XCTAssert(request.responseHandler == ReferenceInterestsResponseHandler.self)
    }
    
    func testReferenceDataPropertyTypeCode() {
        let givenBaseUrl = "http://api.propertyguru.com.sg"
        let request = ReferencePropertyTypeCodeRequest(baseUrl: givenBaseUrl, locale: nil)
        let expectedPath = "/referencedata/getPropertyTypeCode"
        XCTAssert(request.apiPath == expectedPath)
        XCTAssert(request.baseUrl == givenBaseUrl)
        XCTAssert(request.responseHandler == ReferencePropertyTypeCodeResponseHandler.self)
    }
    
    func testReferenceDataRegionCode() {
        let givenBaseUrl = "http://api.propertyguru.com.sg"
        let request = ReferenceRegionCodeRequest(baseUrl: givenBaseUrl, locale: "th")
        let expectedPath = "/th/referencedata/getRegionCode"
        XCTAssert(request.apiPath == expectedPath)
        XCTAssert(request.baseUrl == givenBaseUrl)
        XCTAssert(request.responseHandler == ReferenceRegionCodeResponseHandler.self)
    }
    
    func testReferenceDataDistricts() {
        let givenBaseUrl = "http://api.propertyguru.com.sg"
        let request = ReferenceDistrictsRequest(baseUrl: givenBaseUrl, locale: "th")
        let expectedPath = "/th/referencedata/getDistricts"
        XCTAssert(request.apiPath == expectedPath)
        XCTAssert(request.baseUrl == givenBaseUrl)
        XCTAssert(request.responseHandler == ReferenceDistrictResponseHandler.self)
    }
    
    func testReferenceDataGeographicalArea() {
        let givenBaseUrl = "http://api.propertyguru.com.sg"
        let request = ReferenceGeographicAreaRequest(baseUrl: givenBaseUrl, locale: "th")
        let expectedPath = "/th/referencedata/getGeographicArea"
        XCTAssert(request.apiPath == expectedPath)
        XCTAssert(request.baseUrl == givenBaseUrl)
        XCTAssert(request.responseHandler == ReferenceRegionCodeResponseHandler.self)
        
        let requestA = ReferenceGeographicAreaA_Request(baseUrl: givenBaseUrl, locale: "th")
        let expectedPathA = "/th/referencedata/getGeographicArea/A"
        XCTAssert(requestA.apiPath == expectedPathA)
        XCTAssert(requestA.baseUrl == givenBaseUrl)
        XCTAssert(requestA.responseHandler == ReferenceGeographicAreaResponseHandler.self)
        
        let requestL = ReferenceGeographicAreaL_Request(baseUrl: givenBaseUrl, locale: "th")
        let expectedPathL = "/th/referencedata/getGeographicArea/L"
        XCTAssert(requestL.apiPath == expectedPathL)
        XCTAssert(requestL.baseUrl == givenBaseUrl)
        XCTAssert(requestL.responseHandler == ReferenceRegionCodeResponseHandler.self)
        
        let requestN = ReferenceGeographicAreaN_Request(baseUrl: givenBaseUrl, locale: "th")
        let expectedPathN = "/th/referencedata/getGeographicArea/N"
        XCTAssert(requestN.apiPath == expectedPathN)
        XCTAssert(requestN.baseUrl == givenBaseUrl)
        XCTAssert(requestN.responseHandler == ReferenceRegionCodeResponseHandler.self)
        
        let requestD = ReferenceGeographicAreaD_Request(baseUrl: givenBaseUrl, locale: "th")
        let expectedPathD = "/th/referencedata/getGeographicArea/D"
        XCTAssert(requestD.apiPath == expectedPathD)
        XCTAssert(requestD.baseUrl == givenBaseUrl)
        XCTAssert(requestD.responseHandler == ReferenceGeographicDistrictResponseHandler.self)
    }
}
