import Foundation
import Combine
import SwiftUI

protocol ScheduleTimeServiceType {
    func me() -> AnyPublisher<APIResult<AccountMeEntity>, Never>
    
    func get(
        offset: Int,
        limit: Int,
        search: String?
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<AccountEntity>>, Never>
}

final class ScheduleTimeService: AccountServiceType {
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
                "search": search ?? ""
            ]
        )
    }
}

struct ScheduleTimeServiceKey: EnvironmentKey {
    static let defaultValue: ScheduleTimeService = ScheduleTimeService()
}

extension EnvironmentValues {
    var scheduleTimeService: ScheduleTimeService {
        get {
            self[ScheduleTimeServiceKey.self]
        }
        set {
            self[ScheduleTimeServiceKey.self] = newValue
        }
    }
}

