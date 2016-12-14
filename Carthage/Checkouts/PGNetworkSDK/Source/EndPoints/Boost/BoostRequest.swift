import Foundation

public struct BoostCreateRequest: PGApiRequest {
    
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = BoostCreateResponseHandler.self
    var isAccessTokenRequired: Bool = false
    var httpMethod: PGRequestHttpMethod = .post
    var apiPath: String? = PGApiPath("Boost", "Create")
    public var baseUrl: String?
    
    let listingId: String
    let tierType: Int
    let startDate: Date
    let weeks: Int
    
    public init(listingId: String, tierType: Int, startDate: Date, weeks: Int) {
        self.listingId = listingId
        self.tierType = tierType
        self.startDate = startDate
        self.weeks = weeks
    }
    
    var parameters: [String: Any]? {
        let startDateTimeStamp = Int(startDate.timeIntervalSince1970)
        return ["listingId": listingId, "tierType": tierType, "startDate": startDateTimeStamp, "duration": weeks]
    }
    
}

public struct BoostExtendRequest: PGApiRequest {
    
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = BoostCreateResponseHandler.self
    var isAccessTokenRequired: Bool = false
    var httpMethod: PGRequestHttpMethod = .post
    var apiPath: String? = PGApiPath("Boost", "Extend")
    public var baseUrl: String?
    
    let listingId: String
    let tierType: Int
    let weeks: Int
    
    public init(listingId: String, tierType: Int, weeks: Int) {
        self.listingId = listingId
        self.tierType = tierType
        self.weeks = weeks
    }
    
    var parameters: [String: Any]? {
        return ["listingId": listingId, "tierType": tierType, "duration": weeks]
    }
    
}

public struct BoostChargeRequest: PGApiRequest {
    
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = BoostChargeResponseHandler.self
    var isAccessTokenRequired: Bool = true
    var httpMethod: PGRequestHttpMethod = .get
    var apiPath: String? = PGApiPath("Boost", "Charges")
    
    public init() {
    }
    
    var parameters: [String: Any]? {
        guard let country = PGNetworkSDK.sharedInstance.country else { return nil }
        return ["region": country]
    }
    
}

public struct BoostActiveRequest: PGApiRequest {
    
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = BoostActiveResponseHandler.self
    var isAccessTokenRequired: Bool = true
    var httpMethod: PGRequestHttpMethod = .get
    var apiPath: String? = PGApiPath("Boost", "Active")
    
    let listingId: String
    
    public init(listingId: String) {
        self.listingId = listingId
    }
    
    var parameters: [String: Any]? {
        guard let country = PGNetworkSDK.sharedInstance.country else { return nil }
        return ["region": country, "listingIds": listingId]
    }
    
}

public struct CreditQueryRequest: PGApiRequest {
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = CreditQueryResponseHandler.self
    var isAccessTokenRequired: Bool = false
    var httpMethod: PGRequestHttpMethod = .get
    var apiPath: String? = PGApiPath("Boost", "CreditQuery")
    var parameters: [String: Any]?
    public var baseUrl: String?
    
    public init() { }

}
