import Combine

protocol AuthenticationServiceType {
    func login(
        mail: String,
        password: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never>
    
    func refreshToken(
        token: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never>
    
    func test() -> AnyPublisher<APIResult<AccountMeEntity>, Never>
}

final class AuthenticationService: AuthenticationServiceType {
    func login(
        mail: String,
        password: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never> {
        Agent.agent.run(
            "/authentication/",
            method: .put,
            params: [
                "mail": mail,
                "password": password,
            ],
            type: .application
        )
    }
    
    func refreshToken(
        token: String
    ) -> AnyPublisher<APIResult<AuthenticationEntity>, Never> {
        Agent.agent.run(
            "/authentication/token/\(token)",
            method: .post,
            type: .none
        )
    }
    
    func test() -> AnyPublisher<APIResult<AccountMeEntity>, Never> {
        Agent.agent.run(
            "/account/me"
        )
    }
}
