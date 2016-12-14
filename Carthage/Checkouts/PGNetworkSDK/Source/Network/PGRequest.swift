//
//  PGNetworkRequest.swift
//  Pods
//
//  Created by Suraj Pathak on 11/3/16.
//
//

import Foundation

enum PGRequestHttpMethod: String {
    case get
    case post
    case put
    case delete
}

enum PGRequestState: Int {
    case normal  	/* Freshly created */
    case running 	/* The task is currently being serviced by the session */
    case suspended 	/* Cancelled or suspenede */
    case canceling 	/* The task has been told to cancel */
    case completed 	/* The task has completed and the session will receive no more delegate notifications */
    case timedOut 	/* Request timed out */
}

protocol PGRequest {
    // Without default implementation, must be provided by conforming type
    var apiPath: String? { get }
    var parameters: [String: Any]? { get }
    
    // With default implenetation via extension
    var networkManager: PGNetworkManagerProtocol { get }
    var httpMethod: PGRequestHttpMethod { get }
    var state: PGRequestState { get }
    var cachingEnabled: Bool { get }
    var fullApiPath: String? { get }
    var requestParameters: [String: Any]? { get }
    var basicAuthUsername: String? { get }
    var basicAuthPassword: String? { get }
}

extension PGRequest {
    var networkManager: PGNetworkManagerProtocol {
        get { return PGNetworkManager.sharedInstance }
    }
    var httpMethod: PGRequestHttpMethod { return .get }
    var state: PGRequestState { return .normal }
    var cachingEnabled: Bool { return false }
    var fullApiPath: String? {
        get {
            return apiPath
        }
    }
    
    var requestParameters: [String: Any]? {
        get {
           return parameters
        }
    }
}
