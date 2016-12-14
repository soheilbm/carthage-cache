import Foundation

protocol PGNetworkManagerProtocol {
    func request(_ queue: DispatchQueue?, request: PGRequest, success: @escaping ((Any) -> Void), failure: @escaping ((PGNetworkError) -> Void))
    func cancelRequest(_ request: PGRequest)
}

class PGNetworkManager {
    static let sharedInstance = PGNetworkManager()
}

extension PGNetworkManager: PGNetworkManagerProtocol {
    
    internal func request(_ queue: DispatchQueue? = nil, request: PGRequest, success: @escaping ((Any) -> Void), failure: @escaping ((PGNetworkError) -> Void)) {
        guard let url = request.completeUrl() else {
            failure(PGNetworkError.invalidError)
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = request.httpMethod.rawValue
        if request.httpMethod == .post || request.httpMethod == .put {
            urlRequest.httpBody = request.postParametersBody()
        }
        
        let headers = ["content-type": "application/x-www-form-urlencoded"]
        
        urlRequest.allHTTPHeaderFields = headers
        printCurl(urlRequest: urlRequest)
        
        let queueToExecute = queue ?? DispatchQueue.main
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let d = data, let json = try? JSONSerialization.jsonObject(with: d, options: []), let resp = response as? HTTPURLResponse else {
                queueToExecute.async { failure(PGNetworkError(systemError: error)) }
                return
            }
            if resp.statusCode == 400 {
                queueToExecute.async { failure(PGNetworkError(json: json)) }
            } else if 200...299 ~= resp.statusCode {
                queueToExecute.async { success(json) }
            } else {
                queueToExecute.async { failure(PGNetworkError.invalidError) }
            }
        }
        task.resume()
    }
    
    func cancelRequest(_ request: PGRequest) {
        // TODO: To be implemented
    }
    
    func printCurl(urlRequest request: URLRequest) {
        guard let method = request.httpMethod, let url = request.url else { return }
        var headerString: String = ""
        if let headers = request.allHTTPHeaderFields {
            headers.forEach {
                headerString.append("-H '\($0): \(String.init(describing: $1))' ")
            }
        }
        var dataString: String = ""
        if let body = request.httpBody {
            if let bodyString = String(data: body, encoding: String.Encoding.utf8) {
                dataString = "-d '\(bodyString)'"
            }
        }
        #if DEBUG
            print("curl -X \(method.uppercased()) \(headerString)\(dataString) '\(url.absoluteString)'")
        #endif
    }
    
}

extension PGRequest {
    
    func completeUrl() -> URL? {
        guard var fullPath = self.fullApiPath else { return nil }
        guard self.httpMethod == .get else { return URL(string: fullPath) }
        if let paramUrl = getParameterStrings() {
            fullPath.append("?\(paramUrl)")
        }
        return URL(string: fullPath)
    }
    
    func getParameterStrings() -> String? {
        var stringArray: [String] = []
        guard let params = requestParameters else { return nil }
        params.forEach { stringArray.append("\($0)=\(String.init(describing: $1))") }
        return stringArray.joined(separator: "&").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
    
    func postParametersBody() -> Data? {
        guard let params = getParameterStrings() else { return nil }
        return params.data(using: String.Encoding.utf8)
    }
    
}
