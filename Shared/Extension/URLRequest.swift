import Foundation

extension URLRequest {
    init(
        _ url: URL,
        method: HTTPMethod = .get,
        params: [String: Any] = [:],
        headers: [String: Any] = [:]
    ) {
        // params
        self.init(
            url: url.appending(params.map { (key, value) in
                URLQueryItem(name: key, value: String(describing: value))
            })!
        )
        
        self.httpMethod = method.rawValue
        
        // headers
        for (key, value) in headers {
            self.setValue(String(describing: value), forHTTPHeaderField: key)
        }
    }
}
