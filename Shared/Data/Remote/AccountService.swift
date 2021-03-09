import Foundation
import Combine
import SwiftUI

final class AccountService: EntityServiceType {
    @Environment(\.agent)
    var agent: Agent

    func get(
        offset: Int = 0,
        limit: Int = 30,
        search: String? = nil
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<AccountEntity>>, Never> {
        self.get(offset: offset, limit: limit, search: search, scope: [])
    }
    
	func get(
		offset: Int = 0,
		limit: Int = 30,
		search: String? = nil,
        scope: [String] = ["teacher"]
	) -> AnyPublisher<APIResult<CollectionMetaResponse<AccountEntity>>, Never> {
		self.agent.run(
			"/account/",
			params: [
				"offset": offset,
				"limit": limit,
				"search": search ?? "",
                "scope": scope.joined(separator: ",")
			]
		)
	}
    
    func delete(id: Int) -> AnyPublisher<APIResult<AccountEntity>, Never> {
        self.agent.run(
            "/account/\(id)",
            method: .delete
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
