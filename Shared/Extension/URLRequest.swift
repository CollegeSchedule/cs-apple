import Foundation

extension URLRequest {
    init(
        _ url: URL,
        method: HTTPMethod = .get,
        params: [String: Any?] = [:],
        headers: [String: Any] = [:]
    ) {
        self.init(
            url: (method != .get) ? url : url.appending(params.filter {
                $0.value != nil
            }.map {
                (key, value) in
                
                URLQueryItem(name: key, value: String(describing: value!))
            })!
        )
        
        self.httpMethod = method.rawValue
        
        // headers
        self.setValue(
            "application/json; charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
        
        for (key, value) in headers {
            self.setValue(String(describing: value), forHTTPHeaderField: key)
        }
    }
    
    func authenticate(token: String) -> URLRequest {
        let request = (self as NSURLRequest)
            .mutableCopy() as! NSMutableURLRequest
        
        request.setValue(
            token,
            forHTTPHeaderField: "accessToken"
        )
        
        return request as URLRequest
    }
}
