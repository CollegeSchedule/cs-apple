import SwiftUI
import Combine

extension ScheduleView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.scheduleSubjectService)
        private var subjectService: ScheduleSubjectService
        
        @Environment(\.scheduleTimeSubjectService)
        private var customTimeSubjectService: ScheduleTimeSubjectService
        
        @Published
        var time: APIResult<ScheduleTimeSubject> = .loading
        
        @Published
        var lessonsTime: ScheduleItemLessons =
            ScheduleItemLessons(
                item: [],
                weekdays: ScheduleTimeSubject(
                    weekdays: [],
                    weekends: [])
            )
        
        @Published
        var selection: Int = 0
        
        private var groupId: Int? = nil
        private var accountId: Int? = nil
        private let year: Int = Calendar.current.component(.year, from: Date())
        private let week: Int = Calendar.current.component(.weekOfYear,from: Date())
        
        init(
            accountId: Int? = nil,
            groupId: Int? = nil
        ) {
            self.accountId = accountId
            self.groupId = groupId
            
            super.init()
            
            self.performGetOperation(
                networkCall: self.customTimeSubjectService.get()
            )
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .sink { result in
                if case let .success(content) = result {
                    self.lessonsTime.weekdays = content
                }
            }
            .store(in: &self.bag)
            
            self.$selection
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .flatMap { result -> AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never> in
                    return self.performGetOperation(
                        networkCall: self.subjectService.get(
                            groupId: self.groupId,
                            year: self.year,
                            week: self.week + self.selection,
                            accountId: self.accountId
                        )
                    )
                }
                .sink { result in
                    if case let .success(content) = result {
                        self.lessonsTime.item = content.items
                    }
                }
                .store(in: &self.bag)
        }
    }
}
