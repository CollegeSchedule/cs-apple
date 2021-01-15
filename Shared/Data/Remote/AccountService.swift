import Foundation
import Combine
import SwiftUI

protocol AccountServiceType {
    func me() -> AnyPublisher<APIResult<AccountMeEntity>, Never>
    
    func get(
		offset: Int,
        limit: Int,
		search: String?
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<AccountEntity>>, Never>
}

final class AccountService: AccountServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func me() -> AnyPublisher<APIResult<AccountMeEntity>, Never> {
        self.agent.run(
            "/account/me"
        )
    }
	
	func get(
		offset: Int = 0,
		limit: Int = 30,
		search: String? = nil
	) -> AnyPublisher<APIResult<CollectionMetaResponse<AccountEntity>>, Never> {
		self.agent.run(
			"/account/",
			params: [
				"offset": offset,
				"limit": limit,
				"search": search ?? "",
                "scope": "teacher"
			]
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
