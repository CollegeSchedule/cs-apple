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
                            year: self.week == 52 && self.selection == 1
                                ? self.year + 1
                                : self.year,
                            week: self.week == 52 && self.selection == 1
                                ? 1
                                : self.week + self.selection,
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
        
        func weekDate(_ date: Date) -> [WeekDay] {
            let calendar = Calendar.init(identifier: .gregorian)
            let dayOfWeek = calendar.component(.weekday, from: date) - 1
            let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: date)!
            return (weekdays.lowerBound ..< weekdays.upperBound - 1)
                .compactMap {
                    
                    if dayOfWeek - 1 == $0 {
                        return WeekDay(
                            id: $0,
                            name: "authenticated.schedule.yesterday"
                        )
                    }
                    
                    if dayOfWeek == $0 {
                        return WeekDay(
                            id: $0,
                            name: "authenticated.schedule.today"
                        )
                    }
                    
                    if dayOfWeek + 1 == $0 {
                        return WeekDay(
                            id: $0,
                            name: "authenticated.schedule.tomorrow"
                        )
                    }
                    
                    return WeekDay(
                        id: $0,
                        name: DateFormatter.WEEK_DAY_FORMATTER.string(
                            from: calendar
                                .date(
                                    byAdding: .day,
                                    value: $0 - dayOfWeek,
                                    to: date
                                )!
                        )
                    )
                }
        }
    }
}
