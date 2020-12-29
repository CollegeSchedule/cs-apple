import Foundation
import Combine
import SwiftUI

protocol ScheduleTimeSubjectServiceType {
    func get() -> AnyPublisher<APIResult<ScheduleTimeSubject>, Never>
}

final class ScheduleTimeSubjectService: ScheduleTimeSubjectServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func get() -> AnyPublisher<APIResult<ScheduleTimeSubject>, Never> {
        self.agent.run(
            "/custom/schedule/time/subject/"
        )
    }
}

struct ScheduleTimeSubjectServiceKey: EnvironmentKey {
    static let defaultValue: ScheduleTimeSubjectService = ScheduleTimeSubjectService()
}

extension EnvironmentValues {
    var scheduleTimeSubjectService: ScheduleTimeSubjectService {
        get {
            self[ScheduleTimeSubjectServiceKey.self]
        }
        set {
            self[ScheduleTimeSubjectServiceKey.self] = newValue
        }
    }
}

