import Foundation

public struct {{MODULENAME}}Request: PGApiRequest {
    
    var networkManager: PGNetworkManagerProtocol = PGNetworkManager.sharedInstance
    var responseHandler: PGResponse.Type = {{MODULENAME}}ResponseHandler.self
    var isAccessTokenRequired: Bool = true
    var httpMethod: PGRequestHttpMethod = .get // TODO: Make sure the http method is the desired type
    var apiPath: String? = PGApiPath("key1", "key2") // TODO: Use the correct api path
    
    public init() {
        // TODO
    }
    
    var parameters: [String: Any]? {
        return [:] // TODO
    }
    
}
