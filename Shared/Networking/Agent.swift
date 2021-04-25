import Foundation
import SwiftUI
import Combine
import SPAlert

class Agent: ObservableObject {
    // MARK: - URLSession
    private let session: URLSession = .shared
    
    @Environment(\.accountService)
    var accountService: AccountService
    
    // MARK: - Application credentials
    private let base: URL = URL(string: "https://api.collegeschedule.ru:2096")!
//    private let base: URL = URL(string: "http://192.168.0.151:5000")!
    private let token: String = "f14eed27-87ec-42e3-981f-a21c575fd85e"
    
    func run<T: Codable>(
        _ path: String,
        
        method: HTTPMethod = .get,
        params: [String: Any?] = [:],
        headers: [String: Any] = [:],
        
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<APIResult<T>, Never> {
        var request = URLRequest.init(
            self.base.appendingPathComponent(path),
            method: method,
            params: params,
            headers: [
                "accessToken": self.token
            ].merging(headers) {
                (current, _) in current
            }
        )
                
        if method != .get {
            request.httpBody = try! JSONSerialization.data(withJSONObject: params.compactMapValues { $0 })
        }

        return self.request(request)
    }
    
    private func request<T: Codable>(_ request: URLRequest) -> AnyPublisher<APIResult<T>, Never> {
        return self.session
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
            .flatMap { result -> AnyPublisher<APIResult<T>, Never> in
                guard let data = result.data, result.status else {
                    return Just(APIResult.error(result.error!)).eraseToAnyPublisher()
                }
                
                return Just(APIResult.success(data)).eraseToAnyPublisher()
            }
            .catch { error -> Just<APIResult<T>> in Just(.error(APIError())) }
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .share()
            .eraseToAnyPublisher()
    }
}

struct AgentKey: EnvironmentKey {
    static let defaultValue: Agent = Agent()
}

extension EnvironmentValues {
    var agent: Agent {
        get {
            self[AgentKey.self]
        }
        set {
            self[AgentKey.self] = newValue
        }
    }
}
