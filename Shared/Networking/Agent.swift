import Foundation
import SwiftUI
import Combine

class Agent: ObservableObject {
    // MARK: - URLSession
    private let session: URLSession = .shared
    
    @Environment(\.authenticationService)
    var authenticationService: AuthenticationService
    
    @Environment(\.accountService)
    var accountService: AccountService
    
    // MARK: - Application credentials
    private let base: URL = URL(string: "https://api.collegeschedule.ru:2096")!
    private let token: String = "8d181a53-f87b-4377-a057-cd07c49af82f"
    private let secret: String = "3162c1b0-e25f-4b7d-9c2d-d99096d9a984"
    
    // MARK: - Account credentials (temporary solution)
    @Published("access_token")
    private(set) var access: String = ""
    
    @Published("refresh_token")
    private(set) var refresh: String = ""
    
    @Published
	var isAuthenticated: Bool = false {
		didSet {
            if !self.isAuthenticated {
                self.access = ""
                self.refresh = ""
            }
		}
	}
    
    // MARK: - TODO: Check token on application launch
    init() {
        self.isAuthenticated = !self.access.isEmpty && !self.refresh.isEmpty
    }
    
    func run<T: Codable>(
        _ path: String,
        
        method: HTTPMethod = .get,
        params: [String: Any?] = [:],
        headers: [String: Any] = [:],
        
        decoder: JSONDecoder = JSONDecoder(),
        type: AuthenticationType = .account
    ) -> AnyPublisher<APIResult<T>, Never> {
        var request = URLRequest.init(
            self.base.appendingPathComponent(path),
            method: method,
            params: params,
            headers: ((type == .account)
                        ? [
                            "accessToken": self.access
                        ] : [
                            "appToken": self.token,
                            "appSecret": self.secret
                        ]
            ).merging(headers) {
                (current, _) in current
            }
        )
                
        if method != .get {
            request.httpBody = try! JSONSerialization.data(
                withJSONObject: params.compactMapValues { $0 }
            )
        }
        print("Access: \(self.access)")
        return self.request(request)
    }
    
    private func request<T: Codable>(
        _ request: URLRequest
    ) -> AnyPublisher<APIResult<T>, Never> {
        return self.session
            .dataTaskPublisher(
                for: request
            )
            .map {
                return $0.data
            }
            .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
            .flatMap { result -> AnyPublisher<APIResult<T>, Never> in
                print("\(request.httpMethod!.description) \(request.description)")
                
                guard let data = result.data, result.status else {
                    guard result.error!.code == 4 else {
                        return Just(APIResult.error(result.error!))
                            .eraseToAnyPublisher()
                    }
                    
                    guard result.error!.code == 4,
                          request.description.contains("/authentication/token/")
                    else {
                        return self.authenticationService
                            .refreshToken(token: self.refresh)
                            .flatMap { (
                                result: APIResult<AuthenticationEntity>
                            ) -> AnyPublisher<APIResult<T>, Never> in
                                if case let .success(authentication) = result {
                                    return self.request(
                                        request.authenticate(
                                            token: authentication.access.token
                                        )
                                    )
                                }
                                
                                return Just(APIResult.error(.init()))
                                    .eraseToAnyPublisher()
                            }
                            .eraseToAnyPublisher()
                    }
                    
                    Scheduler.main.perform {
                        self.access = ""
                        self.refresh = ""
                        self.isAuthenticated = false
                    }
                    
                    return Just(.error(.init(code: -1)))
                        .eraseToAnyPublisher()
                }
                
                // if response succed and method is authentication
                if result.status,
                   request.httpMethod != "GET",
                   request.description.contains("/authentication/") {
                    let authentication = result.data as! AuthenticationEntity

                    Scheduler.main.perform {
                        self.access = authentication.access.token
                        self.refresh = authentication.refresh.token
                        self.isAuthenticated = true
                    }
                }
                                
                return Just(APIResult.success(data))
                    .eraseToAnyPublisher()
            }
            .catch { error -> Just<APIResult<T>> in
                print("Error \(error)")
                return Just(.error(APIError()))
            }
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
