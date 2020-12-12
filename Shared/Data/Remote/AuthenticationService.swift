import Combine
import SwiftUI

protocol AuthenticationServiceType {
    func login(
        token: String?,
        mail: String?,
        password: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never>
    
    func register(
        token: String?,
        mail: String?,
        password: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never>
    
    func refreshToken(
        token: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never>
    
    func scanner(
        token: String
    ) -> AnyPublisher<APIResult<AuthenticationScannerEntity>, Never>
}

final class AuthenticationService: AuthenticationServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func register(
        token: String? = nil,
        mail: String? = nil,
        password: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never> {
        return self.agent.run(
            "/authentication/",
            method: .post,
            params: [
                "token": token,
                "mail": mail,
                "password": password
            ],
            type: .application
        )
    }
    
    func login(
        token: String? = nil,
        mail: String? = nil,
        password: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never> {
        return self.agent.run(
            "/authentication/",
            method: .put,
            params: [
                "token": token,
                "mail": mail,
                "password": password
            ],
            type: .application
        )
    }
    
    func refreshToken(
        token: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never> {
        self.agent.run(
            "/authentication/token/\(token)",
            method: .post,
            type: .none
        )
    }
    
    func scanner(
        token: String
    ) -> AnyPublisher<APIResult<AuthenticationScannerEntity>, Never> {
        self.agent.run(
            "/authentication/",
            params: [
                "token" : token
            ],
            type: .application
        )
    }
}

struct AuthenticationServiceKey: EnvironmentKey {
    static let defaultValue: AuthenticationService = AuthenticationService()
}

extension EnvironmentValues {
    var authenticationService: AuthenticationService {
        get {
            self[AuthenticationServiceKey.self]
        }
        set {
            self[AuthenticationServiceKey.self] = newValue
        }
    }
}
