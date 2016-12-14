//
//  MadDog.swift
//  PanelPlace
//
//  Created by Suraj Pathak on 10/8/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

/// Bulldog is a super-fast json parser that will keep attacking until it gets the value you desire, or you give up. Just like a bulldog.

public protocol PathType {}
extension String: PathType {}
extension Int: PathType {}

public struct Bulldog {
    let json: Any
    
    public init(json: Any) {
        self.json = json
    }
    
    // Helper methods
    public func stringFromPossibleInt(_ keyPath: PathType...) -> String? {
        if let str = raw(keyPath) as? String {
            return str
        } else if let intStr = raw(keyPath) as? Int {
            return String(describing: intStr)
        }
        return nil
    }
    
    public func string(_ keyPath: PathType...) -> String? {
        return raw(keyPath) as? String
    }
    
    public func int(_ keyPath: PathType...) -> Int? {
        return raw(keyPath) as? Int
    }
    
    public func double(_ keyPath: PathType...) -> Double? {
        return raw(keyPath) as? Double
    }
    
    public func bool(_ keyPath: PathType...) -> Bool {
        return raw(keyPath) as? Bool ?? false
    }
    
    // This one should be enough to parse most of the values
    public func value<T: Equatable>(_ keyPath: PathType...) -> T? {
        return raw(keyPath) as? T
    }
    
    public func dictionary(_ keyPath: PathType...) -> [String: Any]? {
        return raw(keyPath) as? [String: Any]
    }
    
    public func array(_ keyPath: PathType...) -> [Any]? {
        return raw(keyPath) as? [Any]
    }
    
    public func rawJson(_ keyPath: PathType...) -> Any? {
        return raw(keyPath)
    }

    private func raw(_ keyPath: [PathType]) -> Any? {
        let count = keyPath.count
        var finalJson: Any? = json
        for i in 0..<count {
            let path = keyPath[i]
            if let dictPath = path as? String {
                if let newJson = finalJson as? [String: Any] {
                    finalJson = newJson[dictPath]
                } else {
                    return nil
                }
            } else if let arrayPath = path as? Int {
                if let newJson = finalJson as? [Any], arrayPath < newJson.count {
                    finalJson = newJson[arrayPath]
                } else {
                    return nil
                }
            }
        }
        return finalJson
    }
    
}
