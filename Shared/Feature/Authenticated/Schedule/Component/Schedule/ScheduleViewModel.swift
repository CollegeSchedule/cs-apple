import SwiftUI
import Combine

extension ScheduleComponentView {
    struct ScheduleViewDayResult: Hashable {
        let day: Int
        let header: String
        let today: Bool
        let items: [ScheduleSubjectEntity]
    }
    
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.scheduleSubjectService)
        private var subjectService: ScheduleSubjectService
        
        @Published var first: APIResult<[ScheduleViewDayResult]> = .loading
        @Published var second: APIResult<[ScheduleViewDayResult]> = .loading
        
        @Published var selection: Int = 0
        
        private var fetched: Bool = false
        private var groupId: Int? = nil
        private var accountId: Int? = nil
        
        private lazy var date: Date = {
            Date()
        }()
        
        private lazy var calendar: Date = {
            var calendar = Calendar(identifier: .gregorian)
            calendar.firstWeekday = 2
            
            let date = calendar.dateComponents(
                [.calendar, .yearForWeekOfYear, .weekOfYear],
                from: Date()
            ).date!
            
            return date
        }()
        
        private lazy var year: Int = {
            Calendar.current.component(.year, from: self.date)
        }()
        
        private lazy var week: Int = {
            Calendar.current.component(.weekOfYear, from: self.date)
        }()
        
        private lazy var day: Int = {
            Calendar.current.component(.day, from: self.date)
        }()
        
        init(accountId: Int? = nil, groupId: Int? = nil) {
            self.accountId = accountId
            self.groupId = groupId

            super.init()
        }
        
        func fetch() {
            self.fetch(to: \.first, week: 0)
            self.fetch(to: \.second, week: 1)
        }

        private func fetch(
            to keyPath: ReferenceWritableKeyPath<ScheduleComponentView.ViewModel, APIResult<[ScheduleViewDayResult]>>,
            week: Int
        ) {
            self.performGetOperation(networkCall: self.subjectService.get(
                year: self.year,
                week: self.week + week,
                accountId: self.accountId,
                groupId: self.groupId
            ))
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .map { result -> APIResult<[ScheduleViewDayResult]> in
                if case let .success(content) = result {
                    if (content.items.isEmpty) {
                        return APIResult<[ScheduleViewDayResult]>.empty
                    }
                    
                    return APIResult.success(
                        Dictionary(grouping: content.items, by: { $0.day })
                            .map { key, value in
                                let date = self.calendar.advanced(by: .init(60 * 60 * 24 * (week * 7 + key)))
                                                        
                                return ScheduleViewDayResult(
                                    day: key,
                                    header: DateFormatter.WEEK_DAY_FORMATTER.string(from: date),
                                    today: Calendar.current.component(.day, from: date) == self.day,
                                    items: value.sorted(by: { $0.sort < $1.sort })
                                )
                            }
                    )
                } else if case let .error(content) = result {
                    return APIResult<[ScheduleViewDayResult]>.error(content)
                } else if case .loading = result {
                    return APIResult<[ScheduleViewDayResult]>.loading
                } else {
                    return APIResult<[ScheduleViewDayResult]>.empty
                }
            }
            .assign(to: keyPath, on: self)
            .store(in: &self.bag)
        }
    }
}
