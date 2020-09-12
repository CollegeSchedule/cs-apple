import Foundation
import Combine

class Agent {
    private let session: URLSession = .shared
    
//    private let base: URL = URL(string: "https://api.whywelive.me:2096")!
//    private let token: String = "8d181a53-f87b-4377-a057-cd07c49af82f"
//    private let secret: String = "3162c1b0-e25f-4b7d-9c2d-d99096d9a984"
    
    private let base: URL = URL(string: "http://localhost:5000")!
    private let token: String = "f9540083-9e4d-447f-bd29-4fd5255e14e2"
    private let secret: String = "4d6f8818-0e65-4cad-9d4e-0075de59174a"
    
    private var access: String = "TEST"
    private var refresh: String = "TEST"
    
    private var headers: [String: Any] = [:]
    
    func run<T: Codable>(
        _ path: String,
        
        method: HTTPMethod = .get,
        params: [String: Any] = [:],
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
                withJSONObject: params
            )
        }
        
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
                guard let data = result.data, result.status else {
                    guard result.error!.code == 4 else {
                        return Just(APIResult.error(result.error!))
                            .eraseToAnyPublisher()
                    }
                    
                    guard result.error!.code == 4,
                          request.description.contains("/authentication/token/")
                    else {
                        return AuthenticationService()
                            .refreshToken(token: self.refresh)
                            .flatMap { (
                                result: APIResult<Authentication>
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
                    
                    // todo: we should go to main screen
                    
                    return Just(.error(.init(code: -1)))
                        .eraseToAnyPublisher()
                }
                
                // if response succed and method is authentication
                if result.status,
                   request.description.contains("/authentication/") {
                    let authentication = result.data as! Authentication
                    
                    self.access = authentication.access.token
                    self.refresh = authentication.refresh.token
                }
                                
                return Just(APIResult.success(data))
                    .eraseToAnyPublisher()
            }
            .catch { error -> Just<APIResult<T>> in
                return Just(.error(APIError()))
            }
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .share()
            .eraseToAnyPublisher()
    }
    
    // MARK: TODO: REFACTOR
    public static var agent: Agent = Agent()
}
