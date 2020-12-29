import Foundation
import Combine
import SwiftUI

protocol GroupServiceType {
    func get(
        offset: Int,
        limit: Int,
        search: String?
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<GroupEntity>>, Never>
}

final class GroupService: GroupServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func get(
        offset: Int = 0,
        limit: Int = 30,
        search: String? = nil
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<GroupEntity>>, Never> {
        self.agent.run(
            "/group/",
            params: [
                "offset": offset,
                "limit": limit,
                "search": search ?? ""
            ]
        )
    }
}

struct GroupServiceKey: EnvironmentKey {
    static let defaultValue: GroupService = GroupService()
}

extension EnvironmentValues {
    var groupService: GroupService {
        get {
            self[GroupServiceKey.self]
        }
        set {
            self[GroupServiceKey.self] = newValue
        }
    }
}
