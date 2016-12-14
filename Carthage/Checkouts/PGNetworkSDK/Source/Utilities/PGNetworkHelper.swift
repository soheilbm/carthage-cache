//
//  PGComparation.swift
//  Pods
//
//  Created by Suraj Pathak on 11/3/16.
//
//

import Foundation

struct PGNetworkHelper {
    
    static func appendParameters(_ parameters: [[String: Any]?]) -> [String: Any]? {
        var params: [String: Any]?
        for object in parameters {
            if let obj = object {
                if params == nil {
                    params = [String: Any]()
                }
                for key in obj.keys {
                    params![key] = obj[key]
                }
            }
        }
        return params
    }
    
}

public struct PGDateHelper {
    
    static func toDateTime(_ string: String, format: String = "yyyy-MM-dd hh:mm:ss.SSSSxxx", timezone: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        var zone = TimeZone.autoupdatingCurrent
        if let timezone = timezone {
            if let newZone = TimeZone(identifier: timezone) { zone = newZone }
        }
        
        dateFormatter.timeZone = zone
        let dateFromString: Date? = dateFormatter.date(from: string)
        return dateFromString
    }
    
    static func toDateTime(_ date: Date, format: String = "yyyy-MM-dd hh:mm:ss.SSSSxxx") -> NSString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return  dateFormatter.string(from: date) as NSString
    }
    
}

struct PGLocationHelper {
    
    static func isValidCoordinate(_ lat: Double, lng: Double) -> Bool {
        if lat == 0 || lng == 0 {
            return false
        }
        
        if lat < -90 || lat > 90 {
            return false
        }
        
        if lng < -180 || lat > 180 {
            return false
        }
        
        return true
    }
    
}

struct PGComparation {
    
    static func areObjectsEqual(_ objects: [NSObject]) -> Bool {
        guard objects.count > 1 else { return false }
        let baseElement = objects.first!
        for element in objects {
            if !(element == baseElement || element.isEqual(baseElement)) {
                return false
            }
        }
        return true
    }
    
}
