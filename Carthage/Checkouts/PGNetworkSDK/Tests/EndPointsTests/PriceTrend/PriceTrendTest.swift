//
//  PriceTrendTest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 15/11/16.
//  Copyright © 2016 PropertyGuru Pte Ltd. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class PriceTrendTest: XCTestCase {
    var sut: PriceTrendSGRequest!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = PriceTrendSGRequest(forSale: true, propertyType: "condo", districtCode: "D19")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com/v1/properties/propertypriceindex"
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("PriceTrend.singapore"), expectedError: nil)
        sut.send(success: { response in
            guard let cat = response as? PriceTrend else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            
            // Meta
            XCTAssertEqual(cat.districtCode, "D19")
            XCTAssertEqual(cat.districts, "Hougang / Punggol / Sengkang")
            XCTAssertEqual(cat.transactionType, .sale)
            XCTAssertEqual(cat.years, [0.5, 1, 2, 5, 10])
            
            XCTAssertEqual(cat.from.year, 2005)
            XCTAssertEqual(cat.from.month, 1)
            XCTAssertEqual(cat.from.day, 1)
            
            XCTAssertEqual(cat.to.year, 2016)
            XCTAssertEqual(cat.to.month, 11)
            XCTAssertEqual(cat.to.day, 11)
            
            XCTAssertEqual(cat.bedTypes, ["1", "2", "3", "4", "All"])
            
            
            // Price Volume
            XCTAssertEqual(cat.priceVolume.count, 5)
            for pv in cat.priceVolume {
                switch pv.bedType {
                case "1":
                    XCTAssertEqual(pv.volume, 164)
                    XCTAssertEqual(pv.avgPsf, 9.9)
                case "2":
                    XCTAssertEqual(pv.volume, 1338)
                    XCTAssertEqual(pv.avgPsf, 10.84)
                case "3":
                    XCTAssertEqual(pv.volume, 4534)
                    XCTAssertEqual(pv.avgPsf, 11.51)
                case "4":
                    XCTAssertEqual(pv.volume, 477)
                    XCTAssertEqual(pv.avgPsf, 9.07)
                case "All":
                    XCTAssertEqual(pv.volume, 6994)
                    XCTAssertEqual(pv.avgPsf, 11.51)
                default:
                    XCTAssertFalse(true, "Should not have any other cases")
                }
            }
            
            let bed1Last3monthsTrend = cat.filtered(bedType: "1", yearRange: 0.25)
            XCTAssertNotNil(bed1Last3monthsTrend)
            if let trend = bed1Last3monthsTrend {
                let volTrend = trend.volumeTrend
                XCTAssertEqual(volTrend.count, 2)
                // Volume trend
                let volTrend0 = volTrend[0]
                XCTAssertEqual(volTrend0.volume, 2)
                XCTAssertEqual(volTrend0.time.month, 9)
                
                let volTrend1 = volTrend[1]
                XCTAssertEqual(volTrend1.volume, 4)
                XCTAssertEqual(volTrend1.time.month, 10)
                
                // Price index trend
                let priceTrend = trend.priceIndex
                XCTAssertEqual(priceTrend.count, 3)
                
                let priceTrend0 = priceTrend[0]
                XCTAssertEqual(priceTrend0.index, 95.135887076513 * 9.9)
                XCTAssertEqual(priceTrend0.time.month, 9)
                
                let priceTrend1 = priceTrend[1]
                XCTAssertEqual(priceTrend1.index, 95.151096326648 * 9.9)
                XCTAssertEqual(priceTrend1.time.month, 10)
                
                let priceTrend2 = priceTrend[2]
                XCTAssertEqual(priceTrend2.index, 95.165595917856 * 9.9)
                XCTAssertEqual(priceTrend2.time.month, 11)
            }
            
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}

extension Date {
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
}
