import Combine
import SwiftUI

protocol AuthenticationServiceType {
    func login(
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
    
    func login(
        token: String? = nil,
        mail: String? = nil,
        password: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never> {
        var params = [
            "password": password
        ]
        
        if token != nil {
            params["token"] = token
        }
        
        if mail != nil {
            params["mail"] = mail
        }
        
        return self.agent.run(
            "/authentication/",
            method: .put,
            params: params,
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
