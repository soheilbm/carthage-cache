//
//  ListingDetailTest.swift
// PGNetworkSDK
//
//  Created by Soheil on 27/4/16.
//  Copyright © 2016 Soheil. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class ListingDetailTest: XCTestCase {
    
    var sut_Detail: PGListingDetailRequest {
        return PGListingDetailRequest("1234")
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
        let expected = "https://api.staging.propertyguru.com.sg/v1/listings/1234"
        let actual = sut_Detail.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_ListingDetail_Parameters() {
        let expected: NSDictionary = [ "locale": "en", "region": "sg", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_Detail.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_ListingDetail_ParametersExtra() {
        let expected: NSDictionary = [ "locale": "en", "region": "sg","_isTracked":"1","device_id":"12345", "access_token": "token"]
        let request = PGListingDetailRequest("1234",deviceId: "12345",isTracked: true)
        let actual = NSDictionary(dictionary: request.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_ListingDetailResponse_ok() {
        var sut = PGListingDetailRequest("9885260",deviceId: "12345",isTracked: true)
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("Listings.indonesia_detail"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success:{ response in
            guard let result = response as? PGListingDetail else {
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.id, 9885260)
            XCTAssertEqual(result.statusCode, "ACT")
            XCTAssertEqual(result.sourceCode, "commaus")
            XCTAssertEqual(result.typeCode, "SALE")
            XCTAssertEqual(result.typeText, "Dijual")
            XCTAssertEqual(result.subTypeCode, nil)
            XCTAssertEqual(result.leaseTermCode, nil)
            XCTAssertEqual(result.leaseTermText, nil)
            XCTAssertEqual(result.featureCode, nil)
            XCTAssertEqual(result.accountTypeCode, "NORMAL")
            XCTAssertEqual(result.isPremiumAccount, true)
            XCTAssertEqual(result.isPropertySpecialistListing, false)
            XCTAssertEqual(result.isMobilePropertySpotlightListing, false)
            XCTAssertEqual(result.isTransactorListing, false)
            XCTAssertEqual(result.hasFloorplans, false)
            XCTAssertEqual(result.hasStream, false)
            XCTAssertEqual(result.localizedTitle, "CLUSTER LA MONTE AVIOLO @GRAND WISATA, BEKASI")
            XCTAssertEqual(result.localizedDescription, "CLUSTER LA MONTE AVIOLO @GRAND WISATA, BEKASI\n\n\nGrand Wisata terus berevolusi dengan membuka permukiman baru, menawarkan kesempatann bagi keluarga muda untuk memenuhi impian memiliki hunian idaman. Di kawasan terbaru ini La Monte hadir dengan konsep modern tropis, yang dirancang untuk tak sekedar berfungsi sebagai ruang tinggal, tetapi juga memberikan rasa nyaman yang didambakan setiap keluarga dari sebuah hunian.\n\nLa Monte terletak di dekat pintu masuk baru Grand Wisata dan terkoneksi dengan wilayah pemukiman di sekitarnya, termasuk akses tol yang dapat dijangkau dalam 5 menit. Lokasi yang menjamin kemudahan akses dan mobilitas Anda.\n\n\nTipe yang dipasarkan :\n6x11 M2\n6x12 M2\n7x11 M2\n7x12 M2\n\nTerms of Payment :\nHard Cash\nInstallment 24x\nKPR DP 30 % Cicil 15x\n\n\nHarga mulai dari : 688 JUTAAN\n\n\nProsedur pemesanan :\n1. FC KTP &amp; NPWP\n2. UTJ 10 juta\n3. Langsung pilih unit\n\nUntuk informasi lebih lanjut, Bapak/Ibu bisa menghubungi saya :\nHarto\n0878-8389-8580\nRay White Summarecon Bekasi\nharto.raywhite@gmail.com\n\nhartoraywhite.blogspot.co.id")
            XCTAssertEqual(result.price, 688000000)
            XCTAssertEqual(result.priceText, "Rp 688 jt")
            XCTAssertEqual(result.pricePerAreaValue, 10424242.4242)
            XCTAssertEqual(result.pricePerAreaUnit, "sqm")
            XCTAssertEqual(result.pricePerAreaReference, "landArea")
            XCTAssertEqual(result.priceTypeCode, "GUI")
            XCTAssertEqual(result.priceTypeText, "Kisaran Harga")
            XCTAssertEqual(result.currency, "Rp")
            XCTAssertEqual(result.bedroomsValue, 2)
            XCTAssertEqual(result.bedroomsText, "2 Kamar Tidur")
            XCTAssertEqual(result.bathroomsValue, 1)
            XCTAssertEqual(result.bathroomsText, "1 Kamar Mandi")
            XCTAssertEqual(result.extraRoomValue, 0)
            XCTAssertEqual(result.extraRoomText, nil)
            XCTAssertEqual(result.floorAreaUnit, "sqm")
            XCTAssertEqual(result.floorAreaValue, 42)
            XCTAssertEqual(result.floorAreaText, "42 m²")
            XCTAssertEqual(result.landAreaUnit, "66 m²")
            XCTAssertEqual(result.landAreaValue, 66)
            XCTAssertEqual(result.landAreaText, "66 m²")
            XCTAssertEqual(result.pricePerFloorAreaUnit, "sqm")
            XCTAssertEqual(result.pricePerFloorAreaValue!, 16380952.380952)
            XCTAssertEqual(result.pricePerFloorAreaText, "Rp 16.380.952 per m²")
            XCTAssertEqual(result.pricePerLandAreaUnit, "sqm")
            XCTAssertEqual(result.pricePerLandAreaValue!, 10424242.424242)
            XCTAssertEqual(result.pricePerLandAreaText, "Rp 10.424.242 per m²")
            XCTAssertEqual(result.propertyStatusCode, "4TOP")
            XCTAssertEqual(result.propertyTypeCode, "BUNG")
            XCTAssertEqual(result.propertyTypeText, "Rumah")
            XCTAssertEqual(result.propertyTypeGroup, "B")
            XCTAssertEqual(result.propertyTenureCode, "O")
            XCTAssertEqual(result.propertyTenureText, "Lainnya")
            XCTAssertEqual(result.propertyUnitId, 9892334)
            XCTAssertEqual(result.hdbEstateCode, "")
            XCTAssertEqual(result.hdbEstateText, nil)
            XCTAssertEqual(result.topMonth, nil)
            XCTAssertEqual(result.topYear, nil)
            XCTAssertEqual(result.floors, nil)
            XCTAssertEqual(result.developer, nil)
            XCTAssertEqual(result.listingQualityScore, 90)
            XCTAssertEqual(result.furnishingCode, "UNFUR")
            XCTAssertEqual(result.furnishingText, "Tak Berperabot")
            XCTAssertEqual(result.apiURL, "https://api.propertyguru.com/v1/listings/9885260?region=id")
            XCTAssertEqual(result.mobileURL, "http://m.rumah.com/listing-properti/9885260")
            XCTAssertEqual(result.desktopURL, "http://www.rumah.com/listing-properti/dijual-cluster-la-monte-aviolo-grand-wisata-bekasi-oleh-harto-rwsb-9885260")
            XCTAssertEqual(result.listingMedia?.agentImagePath, "https://id1-cdn.pgimgs.com/agent/523049/APHO.47301974.V120B.jpg")
            XCTAssertEqual(result.listingLocation?.latitude, nil)
            XCTAssertEqual(result.listingLocation?.longitude, nil)
            XCTAssertEqual(result.listingLocation?.regionCode, "IDJB")
            XCTAssertEqual(result.listingLocation?.regionText, "Jawa Barat")
            XCTAssertEqual(result.listingLocation?.regionSlug, "jawa-barat")
            XCTAssertEqual(result.listingLocation?.districtCode, "IDJB04")
            XCTAssertEqual(result.listingLocation?.districtText, "Bekasi")
            XCTAssertEqual(result.listingLocation?.districtSlug, "bekasi")
            XCTAssertEqual(result.listingLocation?.areaCode, "IDJB04032")
            XCTAssertEqual(result.listingLocation?.areaText, "Grand Wisata")
            XCTAssertEqual(result.listingLocation?.areaSlug, "grand-wisata")
            XCTAssertEqual(result.listingLocation?.fullAddress, "GRAND WISATA, Grand Wisata, Bekasi, Jawa Barat")
            XCTAssertEqual(result.listingLocation?.streetId, 6737)
            XCTAssertEqual(result.listingDates?.timezone, "Asia/Singapore")
            XCTAssertEqual(result.listingDates?.firstPostedDateUnit, 1460476800)
            XCTAssertEqual(result.listingDates?.firstPostedDate!.timeIntervalSince1970, 1460476800)
            XCTAssertEqual(result.listingDates?.lastPostedDateUnit, 1460476800)
            XCTAssertEqual(result.listingDates?.lastPostedDate!.timeIntervalSince1970, 1460476800)
            XCTAssertEqual(result.listingDates?.expiryDateUnit, 1470844800)
            XCTAssertEqual(result.listingDates?.expiryDate!.timeIntervalSince1970, 1470844800)
            XCTAssertEqual(result.listingAgent?.agentId, 523049)
            XCTAssertEqual(result.listingAgent?.name, "Harto Rwsb")
            XCTAssertEqual(result.listingAgent?.mobile, "+628563371833")
            XCTAssertEqual(result.listingAgent?.mobileText, "+62 856 337 1833")
            XCTAssertEqual(result.listingAgent?.phone, "+622129450689")
            XCTAssertEqual(result.listingAgent?.phoneText, "+62 21 2945 0689")
            XCTAssertEqual(result.listingAgent?.jobTitle, nil)
            XCTAssertEqual(result.listingAgent?.showProfile, true)
            XCTAssertEqual(result.listingAgent?.website, nil)
            XCTAssertEqual(result.listingAgent?.agencyId, 12719)
            XCTAssertEqual(result.listingAgent?.agencyName, nil)
            
            }, failure: { error in
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    
}
