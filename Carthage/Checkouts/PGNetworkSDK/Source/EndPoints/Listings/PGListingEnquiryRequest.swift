//
//  PGListingEnquiryRequest.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 13/7/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

public struct PGListingEnquiryRequest: PGApiRequest {
    let agentId: String
    let listingId: String
    let name: String
    let email: String
    let phone: String
    let message: String
    let reason: String
    let enquiryType: String
    
    public var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl // Making this variable public for legacy api
    var apiPath: String?
    var httpMethod: PGRequestHttpMethod = .post
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = PGListingEnquiryResponseHandler.self
    var isAccessTokenRequired: Bool = true
    
    public init(agentId: String, listingId: String, name: String, email: String, phone: String, message: String, reason: String = "iPhone Enquiry", enquiryType: String = "LIST") {
        self.listingId = listingId
        self.agentId = agentId
        self.name = name
        self.email = email
        self.phone = phone
        self.message = message
        self.reason = reason
        self.enquiryType = enquiryType
        
        if let apiPathDetail = PGApiPath("Listings", "Enquiry") {
            apiPath = "\(apiPathDetail)/\(agentId)"
        }
        parameters = getParameters()
    }
    
    func getParameters() -> [String: Any]? {
        let params = [
            "reason": reason,
            "message": message,
            "email": email,
            "name": name,
            "telephone": phone,
            "listing_id": listingId,
            "enquiry_type": enquiryType
        ]
        return params as [String : Any]?
    }
    
}
