import Foundation
import Combine
import SwiftUI

protocol ScheduleSubjectServiceType {
    func get(
        year: Int,
        week: Int,
        accountId: Int?,
        groupId: Int?
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never>
}

final class ScheduleSubjectService: ScheduleSubjectServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func get(
        year: Int,
        week: Int,
        accountId: Int? = nil,
        groupId: Int? = nil
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never> {
        self.agent.run(
            "/schedule/subject/\(year)/\(week)/",
            params: [
                "accountId": accountId,
                "groupId": groupId,
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

