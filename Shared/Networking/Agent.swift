import Foundation
import Combine

struct Agent {
    private let session: URLSession = .shared
    
    let base: URL = URL(string: "http://localhost:5000")!
    
    var headers: [String: Any] = [:]
    
    func run<T: Codable>(
        _ path: String,
        
        method: HTTPMethod = .get,
        params: [String: Any] = [:],
        headers: [String: Any] = [:],
        
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<APIResult<T>, Never> {
        self.session
            .dataTaskPublisher(
                for: URLRequest.init(
                    self.base.appendingPathComponent(path),
                    method: method,
                    params: params,
                    headers: self.headers.merging(headers) {
                        (current, _) in current
                    }
                )
            )
            .map { $0.data }
            .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
            .map { result -> APIResult<T> in
                guard let data = result.data, result.status else {
                    return APIResult.error(result.error!)
                }
                
                return APIResult.success(data)
            }
            .catch { error -> Just<APIResult<T>> in
                return Just(.error(APIError()))
            }
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .share()
            .eraseToAnyPublisher()
    }
}
