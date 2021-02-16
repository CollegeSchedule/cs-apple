import Foundation
import Combine
import SwiftUI

protocol AccountMeServiceType {
    func get() -> AnyPublisher<APIResult<AccountMeEntity>, Never>
    
    func changeMail(new: String) -> AnyPublisher<APIResult<AccountMeEntity>, Never>
    
    func changePassword(old: String, new: String) -> AnyPublisher<APIResult<AccountMeEntity>, Never>
}

final class AccountMeService: AccountMeServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func get() -> AnyPublisher<APIResult<AccountMeEntity>, Never> {
        self.agent.run("/account/me")
    }
    
    func changeMail(new: String) -> AnyPublisher<APIResult<AccountMeEntity>, Never> {
        self.agent.run(
            "/account/me/mail/",
            method: .post,
            params: [
                "new": new,
                "confirm": new
            ]
        )
    }
	
    func changePassword(old: String, new: String) -> AnyPublisher<APIResult<AccountMeEntity>, Never> {
        self.agent.run(
            "/account/me/password/",
            method: .post,
            params: [
                "old": old,
                "new": new,
                "confirm": new
            ]
        )
    }
}

struct AccountMeServiceKey: EnvironmentKey {
    static let defaultValue: AccountMeService = AccountMeService()
}

extension EnvironmentValues {
    var accountMeService: AccountMeService {
        get {
            self[AccountMeServiceKey.self]
        }
        set {
            self[AccountMeServiceKey.self] = newValue
        }
    }
}
