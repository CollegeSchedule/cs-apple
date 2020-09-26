import Foundation

import Combine
import SwiftUI

protocol AccountServiceType {
    func me() -> AnyPublisher<APIResult<AccountMeEntity>, Never>
}

final class AccountService: AccountServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func me() -> AnyPublisher<APIResult<AccountMeEntity>, Never> {
        self.agent.run(
            "/account/me"
        )
    }
}

struct AccountServiceKey: EnvironmentKey {
    static let defaultValue: AccountService = AccountService()
}

extension EnvironmentValues {
    var accountService: AccountService {
        get {
            self[AccountServiceKey.self]
        }
        set {
            self[AccountServiceKey.self] = newValue
        }
    }
}
