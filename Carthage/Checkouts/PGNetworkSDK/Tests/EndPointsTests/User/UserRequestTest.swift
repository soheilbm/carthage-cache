//
//  UserRequestTest.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 30/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import PGNetworkSDK

class UserRequestTest: XCTestCase {
    
    var sut_Login: PGUserLoginRequest {
     	return PGUserLoginRequest(email: "e", password: "p")
    }
    var sut_Signup: PGUserRegisterRequest {
        return PGUserRegisterRequest(title: "t", firstname: "f", lastname: "l", email: "e", mobileCountry: "sg", phone: "p", password: "p", passwordConfirm: "p", subscribed: true)
    }

    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.staging.propertyguru.com.sg"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: API Path
    func test_SignUp_ApiPath() {
        let expected = "https://api.staging.propertyguru.com.sg/en/user/register"
        let actual = sut_Signup.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Login_ApiPath() {
        let expected = "https://api.staging.propertyguru.com.sg/en/user/login"
        let actual = sut_Login.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Parameters
    func test_SignUp_Parameters() {
        let expected: NSDictionary = [ "title": "t", "firstname": "f", "lastname": "l", "email": "e", "mobile_country":"sg", "phone": "p", "password": "p", "password_confirm": "p", "communication_us": true ]
        let actual = NSDictionary(dictionary: sut_Signup.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Login_Parameters() {
        let expected: NSDictionary = ["email": "e", "password": "p", "access_token": "token"]
        let actual = NSDictionary(dictionary: sut_Login.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    // MARK: Network
    func test_Login_Success() {
    	var sut = PGUserLoginRequest(email: "xxx", password: "xxx")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("User.login_ok"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGUserLoginResponse else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.userId, "415592")
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_Login_Failure() {
        var sut = PGUserLoginRequest(email: "xxx", password: "xxx")
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("User.login_fail"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGUserLoginResponse else {
                XCTAssertFalse(true)
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.stat, "error")
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_Register_Success() {
        var sut = PGUserRegisterRequest(title: "t", firstname: "f", lastname: "l", email: "xxxx", mobileCountry: "sg", phone: "88888888", password: "xxxxxxxx", passwordConfirm: "xxxxxxxx", subscribed: true)
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("User.register_ok"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGUserRegisterResponse else {
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.stat, "ok")
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_Register_Fail() {
        var sut = PGUserRegisterRequest(title: "x", firstname: "x", lastname: "x", email: "xxxx", mobileCountry: "x", phone: "x", password: "xxxxxxxx", passwordConfirm: "xxxxxxxx", subscribed: true)
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("User.register_fail"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGUserRegisterResponse else {
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.stat, "error")
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func test_Register_Fail_Exists() {
        var sut = PGUserRegisterRequest(title: "t", firstname: "f", lastname: "l", email: "xxxx", mobileCountry: "sg", phone: "88888888", password: "xxxxxxxx", passwordConfirm: "xxxxxxxx", subscribed: true)
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("User.register_fail_exists"), expectedError: nil)
        let expectation = self.expectation(description: "Network_Success")
        sut.send(success: { response in
            guard let result = response as? PGUserRegisterResponse else {
                return
            }
            expectation.fulfill()
            XCTAssertEqual(result.stat, "error")
            XCTAssertEqual(result.errorMessage, "The email is already registered. Please login, or try another email address.")
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
