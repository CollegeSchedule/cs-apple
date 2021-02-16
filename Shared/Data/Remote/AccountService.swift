import Foundation
import Combine
import SwiftUI

protocol EntityServiceType {
    associatedtype Entity: Codable & Hashable
    
    func get(
        offset: Int,
        limit: Int,
        search: String?,
        scope: [String]
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<Entity>>, Never>
    
    func delete(id: Int) -> AnyPublisher<APIResult<Entity>, Never>
}

final class AccountService: EntityServiceType {
    @Environment(\.agent)
    var agent: Agent

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
