//
//  PGReferenceDataRequest.swift
//  Pods
//
//  Created by Soheil B.Marvasti on 22/3/16.
//
//

import Foundation

protocol ReferenceRequest: PGApiRequest {
    var path: String? { get }
    var locale: String? { get set }
    init(baseUrl: String?, locale: String?)
}

extension ReferenceRequest {
    var apiPath: String? {
        get {
            if let path = self.path, let locale = self.locale {
                return "/" + locale + path
            }
            return self.path
        }
    }
}

public struct ReferenceBaseRequest: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "Base")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceBaseResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}

public struct ReferenceInterestsRequest: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "Interests")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceInterestsResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}


public struct ReferenceRegionCodeRequest: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "RegionCode")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceRegionCodeResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}


public struct ReferenceGeographicAreaRequest: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "GeographicArea")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceRegionCodeResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}

public struct ReferenceGeographicAreaA_Request: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "GeographicArea_A")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceGeographicAreaResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}

public struct ReferenceGeographicAreaD_Request: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "GeographicArea_D")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceGeographicDistrictResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}

public struct ReferenceGeographicAreaN_Request: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "GeographicArea_N")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceRegionCodeResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() {}
}

public struct ReferenceGeographicAreaL_Request: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "GeographicArea_L")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceRegionCodeResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}

public struct ReferenceDistrictsRequest: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "Districts")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferenceDistrictResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}

public struct ReferencePropertyTypeCodeRequest: ReferenceRequest {
    var path: String? = PGApiPath("ReferenceData", "PropertyTypeCode")
    var parameters: [String: Any]?
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = ReferencePropertyTypeCodeResponseHandler.self
    var baseUrl: String? = PGNetworkSDK.sharedInstance.baseUrl
    var locale: String? 
    
    public init(baseUrl: String?, locale: String?) { 
        if let bUrl = baseUrl { 
            self.baseUrl = bUrl
            self.locale = locale
        } 
    }
    public init() { }
}
