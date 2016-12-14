//
//  PGNewsRequestTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 12/3/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PGNewsRequestTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Parameters
    func test_Parameters_FeaturedArticle() {
    	let sut = PGFeaturedArticleRequest(count: 1)
        let expected: NSDictionary = ["limit": 1, "featured": true, "country": "sg", "lang": "en", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters_NewsLatest() {
        let sut = PGLatestNewsRequest(page: 1)
        let expected: NSDictionary = ["page": 1, "limit": 10, "country": "sg", "lang": "en", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters_NewsInCategory() {
        let sut = PGNewsInCategoryRequest(page: 1, slug: "any")
        let expected: NSDictionary = ["page": 1, "limit": 10, "country": "sg", "lang": "en", "category": "any", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters_Categories() {
        let sut = PGCategoriesRequest()
        let expected: NSDictionary = ["country": "sg", "lang": "en", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func testParameters_NewsFull() {
        let sut = PGNewsFullRequest(id: "120826")
        let expected: NSDictionary = ["id": "120826", "country": "sg", "lang": "en", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: ApiPath
    func test_ApiPath_FeaturedArticle() {
        let sut = PGFeaturedArticleRequest(count: 1)
        let expected = "https://api.propertyguru.com/v2/news/list"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_NewsLatest() {
        let sut = PGLatestNewsRequest(page: 1)
        let expected = "https://api.propertyguru.com/v2/news/list"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_NewsInCategory() {
        let sut = PGNewsInCategoryRequest(page: 1, slug: "sg-finance")
        let expected = "https://api.propertyguru.com/v2/news/list"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_Categories() {
        let sut = PGCategoriesRequest()
        let expected = "https://api.propertyguru.com/v2/news/categories"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ApiPath_NewsFull() {
        let sut = PGNewsFullRequest(id: "120826")
        let expected = "https://api.propertyguru.com/v2/news/"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network Response Parser
    func test_Network_FeaturedArticle() {
        var sut = PGFeaturedArticleRequest(count: 1)
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("News.list"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let newsList = response as? PGNewsList else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(newsList.news)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_Network_NewsFull() {
        var sut = PGNewsFullRequest(id: "120826")
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("News.detail"), expectedError: nil)
        sut.send(success: { response in
            guard let news = response as? PGNewsFull else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(news.webUrl)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_Network_NewsCategories() {
        var sut = PGCategoriesRequest()
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("News.categories"), expectedError: nil)
        sut.send(success: { response in
            guard let cat = response as? PGNewsCategoryList else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(cat.categories)
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
