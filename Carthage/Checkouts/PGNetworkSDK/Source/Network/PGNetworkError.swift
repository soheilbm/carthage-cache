//
//  PGNetworkError.swift
//  Pods
//
//  Created by Soheil on 22/3/16.
//
//

import Foundation

open class PGNetworkError: NSObject {
    open let statusCode: Int
    open let message: String
    
    required public init(json: Any) {
        let bulldog = Bulldog(json: json)
        
        if let code: Int = bulldog.value("error", "code"), let message: String = bulldog.value("error", "message") {
            self.statusCode = code
            self.message = message
        } else {
            self.statusCode = -1
            self.message = "Unknown Error"
            return
        }
    }
    
    required public init(error: NSError) {
        statusCode = error.code
        message = error.localizedDescription
    }
    
    required public init(systemError: Error?) {
        if let error = systemError {
            statusCode = -1
            message = error.localizedDescription
        } else {
            statusCode = -1
            message = "Unknown Error"
        }
    }
    
    required public init(code: Int, message: String) {
        statusCode = code
        self.message = message
    }
    
    static let parsingError = PGNetworkError(code: -1, message: "Parsing Error")
    static let invalidError = PGNetworkError(code: 0, message: "Invalid Request")
}

public enum PGNetworkErrorType: Error {
    case jsonErrorType
    case parsingErrorType
    case networkErrorType
}
