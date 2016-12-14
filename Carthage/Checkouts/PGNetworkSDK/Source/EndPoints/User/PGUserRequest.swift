//
//  PGUserRequest.swift
//  Pods
//
//  Created by Suraj Pathak on 22/3/16.
//
//

import Foundation

public struct PGUserCheckLoginRequest: PGApiRequest {
    
    public var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl // Making this variable public to allow change from client
    var apiPath: String? = PGApiPath("User", "Check")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGUserRegisterResponseHandler.self
    var httpMethod: PGRequestHttpMethod = .post
    
    public init() { }
    
}

public struct PGUserLogoutRequest: PGApiRequest {
    
    public var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl // Making this variable public to allow change from client
    var apiPath: String? = PGApiPath("User", "Logout")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGUserRegisterResponseHandler.self
    var httpMethod: PGRequestHttpMethod = .post
    
    public init() { }
    
}

public struct PGUserResetRequest: PGApiRequest {
    let email: String
    public var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl // Making this variable public to allow change from client
    var apiPath: String? = PGApiPath("User", "Reset")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGUserRegisterResponseHandler.self
    var httpMethod: PGRequestHttpMethod = .post
    public init(email: String) {
        self.email = email
        parameters = ["email": email]
    }
}

public struct PGUserLoginRequest: PGApiRequest {
    let email: String
    let password: String

	public var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl // Making this variable public to allow change from client
    var apiPath: String? = PGApiPath("User", "Login")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGUserLoginResponseHandler.self
    var httpMethod: PGRequestHttpMethod = .post
    public init(email: String, password: String) {
        self.email = email
        self.password = password
        parameters = ["email": email, "password": password]
    }
}

public struct PGUserRegisterRequest: PGApiRequest {
    let title: String
    let firstname: String
    let lastname: String
    let email: String
    let mobileCountry: String
    let phone: String
    let password: String
    let passwordConfirm: String
    let subscribed: Bool

	public var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl // Making this variable public to allow change from client
    var apiPath: String? = PGApiPath("User", "Register")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGUserRegisterResponseHandler.self
    var httpMethod: PGRequestHttpMethod = .post
    
    public init(title: String, firstname: String, lastname: String, email: String, mobileCountry: String, phone: String, password: String, passwordConfirm: String, subscribed: Bool) {
        self.title = title
        self.firstname = firstname
        self.lastname = lastname
        self.passwordConfirm = passwordConfirm
        self.email = email
        self.mobileCountry = mobileCountry
        self.phone = phone
        self.password = password
        self.subscribed = subscribed
    }
    var requestParameters: [String: Any]? {
        get {
            return [
                "title": title,
                "firstname": firstname,
                "lastname": lastname,
                "email": email,
                "mobile_country": mobileCountry,
                "phone": phone,
                "password": password,
                "password_confirm": passwordConfirm,
                "communication_us": subscribed
            ]
        }
        
    }
}
