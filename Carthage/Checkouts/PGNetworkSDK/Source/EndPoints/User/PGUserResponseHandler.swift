//
//  PGUserResponseHandler.swift
//  PGNetworkSDK
//
//  Created by Suraj Pathak on 20/9/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct PGUserLoginResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        
        var response = PGUserLoginResponse()
        response.email = bulldog.string("email")
        response.fullname = bulldog.string("fullname")
        response.mobile = bulldog.string("mobile")
        response.role = bulldog.string("role")
        let userIdInt = bulldog.int("user_id")
        if let id = userIdInt { response.userId = "\(id)" }
        response.stat = bulldog.string("stat")
        if let error = bulldog.string("errors", "action_error") {
            response.errorMessage = error
        }
        output = response
    }
    
}

struct PGUserRegisterResponseHandler: PGResponse {
    var output: Any?
    
    init?(bulldog: Bulldog) {
        var response = PGUserRegisterResponse()
        response.stat = bulldog.string("stat")
        response.errorMessage = bulldog.string("errors", "action_error")
        output = response
    }
}
