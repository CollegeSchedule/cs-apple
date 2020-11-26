import Foundation
import Combine
import SwiftUI

protocol ScheduleSubjectServiceType {
    func get(
        groupId: Int?,
        year: Int,
        week: Int,
        accountId: Int?
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never>
}

final class ScheduleSubjectService: ScheduleSubjectServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func get(
        groupId: Int? = nil,
        year: Int,
        week: Int,
        accountId: Int? = nil
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never> {
        self.agent.run(
            "/schedule/subject/\(groupId == nil ? -1 : groupId!)/\(year)/\(week)/",
            params: [
                "accountId": accountId,
            ]
        )
    }
}

struct ScheduleSubjectServiceKey: EnvironmentKey {
    static let defaultValue: ScheduleSubjectService = ScheduleSubjectService()
}

extension EnvironmentValues {
    var scheduleSubjectService: ScheduleSubjectService {
        get {
            self[ScheduleSubjectServiceKey.self]
        }
        set {
            self[ScheduleSubjectServiceKey.self] = newValue
        }
    }
}

