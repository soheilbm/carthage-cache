//
//  PGUserResponse.swift
//  Pods
//
//  Created by Suraj Pathak on 22/3/16.
//
//

import Foundation

public struct PGUserLoginResponse {
    public var email: String?
    public var fullname: String?
    public var role: String?
    public var mobile: String?
    public var userId: String?
    public var stat: String?
    public var errorMessage: String?
}

public struct PGUserRegisterResponse {
    public var stat: String?
    public var errorMessage: String?
}
