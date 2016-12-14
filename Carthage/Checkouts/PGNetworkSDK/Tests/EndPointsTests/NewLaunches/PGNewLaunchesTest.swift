//
//  PGNewLaunchesTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 28/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGFeaturedProjectsTest: XCTestCase {
    var sut: PGFeaturedProjectsRequest  {
        return PGFeaturedProjectsRequest(block: .HomePage)
    }
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.staging.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ApiPath() {
        let expected = "https://api.staging.propertyguru.com/v2/featuredprojects/sg/homepage"
        let actual = sut.fullApiPath!
        XCTAssertEqual(expected, actual)
    }
    
    
    func test_FeaturedProjectResponce_ok() {
        var sut = PGFeaturedProjectsRequest(block: .HomePage)
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("NewLaunches.featuredListing"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success:{ response in
            guard let result = response as? PGFeaturedProjects else {
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.listings?.count, 4)
            XCTAssertEqual(result.listings![0].id, 1732344)
            XCTAssertEqual(result.listings![0].title, "183 LONGHAUS – A Freehold Mixed Development")
            XCTAssertEqual(result.listings![0].developmentName, "183 LONGHAUS – A Freehold Mixed Development")
            XCTAssertEqual(result.listings![0].developerName, "TEE Land Ltd")
            XCTAssertEqual(result.listings![0].priceMin, "S$ 899,000")
            XCTAssertEqual(result.listings![0].priceMax, "S$ 899,000")
            XCTAssertEqual(result.listings![0].pricePretty, "S$ 899,000")
            XCTAssertEqual(result.listings![0].propertyType, "APT")
            XCTAssertEqual(result.listings![0].projectLogo, "https://sg1-cdn.pgimgs.com/developer-listing/1732344/DPLOG.71898314.V120/183-LONGHAUS-A-Freehold-Mixed-Development-Singapore.jpg")
            XCTAssertEqual(result.listings![0].listingType, "SALE")
            XCTAssertEqual(result.listings![0].salesName, "TEE Ventures Pte Ltd")
            XCTAssertEqual(result.listings![0].reviewId, 129866)
            XCTAssertEqual(result.listings![0].reviewCover, "https://sg2-cdn.pgimgs.com/cms/property-review/2016/02/183-Longhaus-living-area-with-high-ceiling-300x169.original.jpg")
            XCTAssertEqual(result.listings![0].reviewTitle, "183 LONGHAUS Review")
            
            }, failure: { error in
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

class PGNewLaunchesTest: XCTestCase {
    
    var sut_List: PGNewLaunchesListRequest {
        var req = PGNewLaunchesListRequest()
        req.regionCode = "sg"
        req.userId = "a"
        req.districtCode = "d1"
        req.sortCriteria = PGListSortCriteria.sortByDate(ascending: true)
        req.topYear = "2018"
        req.minPrice = 10
        req.maxPrice = 100
        req.page = 1
        req.limit = 10
        req.typeCode = "t"
        
        return req
    }
    
    var sut_Detail: PGNewLaunchesDetailRequest {
        let req = PGNewLaunchesDetailRequest(id: "281339")
        
        return req
    }
    
    var sut_Review: PGNewLaunchesReviewRequest {
        let req = PGNewLaunchesReviewRequest(id: "133921")
        
        return req
    }
    
    var sut_ReviewList: PGNewLaunchesReviewListRequest {
        let req = PGNewLaunchesReviewListRequest()
        
        return req
    }
    
    var sut_Constants: PGNewLaunchesConstantsRequest {
        let req = PGNewLaunchesConstantsRequest()
        
        return req
    }
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.staging.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Sort Criteria
    func test_SortCriteria_ByDate_Asc() {
        let sortByDateAsc = PGListSortCriteria.sortByDate(ascending: true)
        let expected: NSDictionary = ["sort": "date", "order": "asc"]
        let actual = NSDictionary(dictionary: sortByDateAsc.sortParameters())
        XCTAssertEqual(expected, actual)
    }
    
    func test_SortCriteria_ByDate_Desc() {
        let sortByDateDesc = PGListSortCriteria.sortByDate(ascending: false)
        let expected: NSDictionary = ["sort": "date", "order": "desc"]
        let actual = NSDictionary(dictionary: sortByDateDesc.sortParameters())
        XCTAssertEqual(expected, actual)
    }
    
    func test_SortCriteria_ByPrice_Asc() {
        let sortByPriceAsc = PGListSortCriteria.sortByPrice(ascending: true)
        let expected: NSDictionary = ["sort": "price", "order": "asc"]
        let actual = NSDictionary(dictionary: sortByPriceAsc.sortParameters())
        XCTAssertEqual(expected, actual)
    }
    
    func test_SortCriteria_ByPrice_Desc() {
        let sortByPriceDesc = PGListSortCriteria.sortByPrice(ascending: false)
        let expected: NSDictionary = ["sort": "price", "order": "desc"]
        let actual = NSDictionary(dictionary: sortByPriceDesc.sortParameters())
        XCTAssertEqual(expected, actual)
    }
    
    // MARK: Parameters
    func test_RequestParameters_List() {
        let expected: NSDictionary = ["targetCountry": "sg", "locale": "en", "userId": "a", "disctrictCode": "d1", "regionCode": "sg", "propertyType": "t", "minPrice": 10, "maxPrice": 100, "sort": "date", "order": "asc", "topYear": "2018", "page": 1, "limit": 10, "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_List.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_RequestParameters_Detail() {
        let expected: NSDictionary = ["targetCountry": "sg", "locale": "en", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_Detail.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_RequestParameters_Review() {
        let expected: NSDictionary = ["access_token": "token"]
        let actual = NSDictionary(dictionary: sut_Review.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_RequestParameters_ReviewList() {
        let expected: NSDictionary = ["page": 1, "limit": 10, "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_ReviewList.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_RequestParameters_Constants() {
        let expected: NSDictionary = ["targetCountry": "sg", "locale": "en"]
        let actual = NSDictionary(dictionary: sut_Constants.getParameters()!)
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Api Path
    func test_ApiPath_List() {
        let expected = "https://api.staging.propertyguru.com/v2/developerprojects/lists"
        let actual = sut_List.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_Detail() {
        let expected = "https://api.staging.propertyguru.com/v2/developerprojects/281339"
        let actual = sut_Detail.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_Review() {
        let expected = "https://api.staging.propertyguru.com/v2/developerprojects/reviews/133921"
        let actual = sut_Review.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_ReviewList() {
        let expected = "https://api.staging.propertyguru.com/v2/developerprojects/reviews/lists/sg/en"
        let actual = sut_ReviewList.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_Constants() {
        let expected = "https://api.staging.propertyguru.com/v2/developerprojects/constants"
        let actual = sut_Constants.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network + Parser
    func test_Network_NewLaunchesList_Success() {
        var sut = PGNewLaunchesListRequest()
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("NewLaunches.list"), expectedError: nil)
        sut.send(success: { response in
            guard let newsList = response as? PGDeveloperProjectList else {
                XCTAssertFalse(true, "Response expected to be PGDeveloperProjectList type")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(newsList.listings)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    // MARK: Network + Parser
    func test_Network_NewLaunchesDetail_Success() {
        let propertyId: Int = 2274237
        var sut = PGNewLaunchesDetailRequest(id: String(propertyId))
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("NewLaunches.detail"), expectedError: nil)
        sut.send(success: { response in
            guard let newsList = response as? PGDeveloperProjectDetail else {
                XCTAssertFalse(true, "Response expected to be PGDeveloperProjectDetail type")
                return
            }
            expectation.fulfill()
            XCTAssertEqual(newsList.propertyId, propertyId)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
