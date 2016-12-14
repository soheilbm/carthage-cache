//
//  PGNetworkStub.swift
// PGNetworkSDK
//
//  Created by Suraj Pathak on 28/3/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation
@testable import PGNetworkSDK

struct MockTestResponseHandler: PGResponse {
    var output: Any?
    init?(bulldog: Bulldog) {}
}

struct MockApiNetworkRequest: PGApiRequest {
    var apiPath: String? = "apiPath"
    var parameters: [String: Any]? = ["key": "value"]
    var responseHandler: PGResponse.Type = MockTestResponseHandler.self
    var baseUrl: String? = nil
    var isAccessTokenRequired: Bool = false
    var httpMethod: PGRequestHttpMethod = .get
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    
    init(path: String?, httpMethod: PGRequestHttpMethod? = .get) {
        apiPath = path
        self.httpMethod = httpMethod ?? .get
    }
}

struct MockNetworkRequest: PGRequest {
    var apiPath: String? = "apiPath"
    var parameters: [String: Any]? = ["key": "value"]
    var responseHandler: PGResponse.Type = MockTestResponseHandler.self
    var httpMethod: PGRequestHttpMethod = .get
    var basicAuthUsername: String? = nil
    var basicAuthPassword: String? = nil
    init(path: String?, httpMethod: PGRequestHttpMethod? = .get) {
        apiPath = path
        self.httpMethod = httpMethod ?? .get
    }
}


class StubPGNetworkManager: PGNetworkManagerProtocol {
    var responseJson: String?
    var nextError: PGNetworkError?
    
    init(expectedJson: String?, expectedError: PGNetworkError?) {
        responseJson = expectedJson
        nextError = expectedError
    }
    
    func request(_ queue: DispatchQueue?, request: PGRequest, success: @escaping ((Any) -> Void), failure: @escaping ((PGNetworkError) -> Void)) {
        if let jsonString = responseJson,
        let data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: true), let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                success(json)
        } else if let error = nextError {
            failure(error)
        }
    }
    
    func cancelRequest(_ request: PGRequest) {
    }
}

struct TestSampleReader {
    static let plistFileName = "TestSampleJson"
    static func valueForKeyPath(_ keypath: String) -> String? {
        guard let plistPath = Bundle(for: StubPGNetworkManager.self).path(forResource: plistFileName, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: plistPath) else { return nil }
        guard let value = valueForKeyPath(keypath, inDictionary: dict) as? String else { return nil }
        return value
    }
    
    fileprivate static func valueForKeyPath(_ keypath: String, inDictionary dictionary: NSDictionary) -> Any? {
        let keys = keypath.components(separatedBy: ".")
        var currentDictionary = dictionary
        for (index, aKey) in keys.enumerated() {
            if index == keys.count - 1 {
                return currentDictionary.value(forKey: aKey)
            }
            guard let dict = currentDictionary.value(forKey: aKey) as? NSDictionary else {
                return nil
            }
            currentDictionary = dict
        }
        return nil
    }
}

/// Helper method to get api path from given keypath
func SampleJson(_ keypath: String) -> String? {
    return TestSampleReader.valueForKeyPath(keypath)
}
