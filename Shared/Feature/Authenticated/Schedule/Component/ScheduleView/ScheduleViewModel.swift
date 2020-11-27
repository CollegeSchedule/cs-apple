import SwiftUI
import Combine

extension ScheduleView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.scheduleSubjectService)
        private var service: ScheduleSubjectService
        
        @Published
        var schedule: [ScheduleSubjectEntity] = []
        
        override init() {
            super.init()
        }
        
        func fetchShedule(accountId: Int? = nil, groupId: Int? = nil) {
            Publishers.CombineLatest(
                self.performGetOperation(
                    networkCall: self.service.get(
                        groupId: groupId,
                        year: 2020,
                        week: 48,
                        accountId: accountId
                    )
                ),
                self.performGetOperation(
                    networkCall: self.service.get(
                        groupId: groupId,
                        year: 2020,
                        week: 49,
                        accountId: accountId
                    )
                )
            )
            .sink(receiveValue: { result in
                if case let .success(first) = result.0,
                   case let .success(second) = result.1 {
                    self.schedule = first.items + second.items.map { item in
                        var modified = item
                        
                        modified.day += 7
                        
                        return modified
                    }
                }
            })
            .store(in: &self.bag)
        }
    }
}
