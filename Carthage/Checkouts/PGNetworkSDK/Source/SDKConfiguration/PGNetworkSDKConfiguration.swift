//
// PGNetworkSDKConfiguration.swift
//  Pods
//
//  Created by Suraj Pathak on 11/3/16.
//
//

import Foundation
import AES

open class PGNetworkSDK: NSObject {
    open static let sharedInstance = PGNetworkSDK()
    fileprivate let plistKey: String = NetworkPlistConfiguration.key
    open var networkAccessToken: String?
    open var baseUrl: String?
    open var country: String?
    open var locale: String?
    open var retryCountOnTimeout: Int = 2
    open var basicAuthUsername: String?
    open var basicAuthPassword: String?
}

class PGNetworkApiPathHandler {
    static let sharedInstance = PGNetworkApiPathHandler()
    let plistFileName = "PGinfo"
    var dataFile: NSDictionary?
    
    init() {
        if let resourcePath = Bundle(for: PGNetworkSDK.self).path(forResource: plistFileName, ofType: "data") {
            do {
                let contents: NSData = try NSData(contentsOfFile: resourcePath, options: .mappedIfSafe)
                if let file = contents.decryptData(withKey: PGNetworkSDK.sharedInstance.plistKey) {
                    self.dataFile = file as NSDictionary?
                }
                return
            } catch {
                return
            }
        }
    }
    
    func valueForKeyPath(_ keypath: [String]) -> String? {
        if let dataFile = dataFile {
            guard let value = valueForKeyPathWithCountry(keypath, inDictionary: dataFile) else { return nil }
            return value
        }
        return nil
    }
    
    fileprivate func valueForKeyPathWithCountry(_ keypath: [String], inDictionary dictionary: NSDictionary) -> String? {
        guard let country = PGNetworkSDK.sharedInstance.country,
            let valueCountry = valueForKeyPath(keypath+[country], inDictionary: dictionary) as? String  else {
                if let valueDefault = valueForKeyPath(keypath+["default"], inDictionary: dictionary) as? String {
                    return valueDefault
                } else { return nil }
        }
        return valueCountry
    }
    
    fileprivate func valueForKeyPath(_ keypath: [String], inDictionary dictionary: NSDictionary) -> Any? {
        var currentDictionary = dictionary
        for (index, aKey) in keypath.enumerated() {
            if index == keypath.count - 1 {
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
func PGApiPath(_ keypath: String...) -> String? {
    return PGNetworkApiPathHandler.sharedInstance.valueForKeyPath(keypath)
}
