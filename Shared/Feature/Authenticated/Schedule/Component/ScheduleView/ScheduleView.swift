import SwiftUI

struct ScheduleView: View {
    @State
    var days: [WeekDay] = []
    
    @State
    var currentIndex: Int = 1
    
    @State
    var currentPage: Int = 1
    
    @State
    var today: Int = 0
    
    var accountId: Int? = nil
    
    var groupId: Int? = nil
    
    @ObservedObject
    private var model: ScheduleView.ViewModel = .init()
    
    var body: some View {
        ScrollView {
            TabView(selection: self.$currentPage) {
                ScheduleItemViewDay(
                    days: self.days.dropLast(7).sorted {
                        $0.id < $1.id
                    },
                    currentIndex: self.$currentIndex,
                    today: self.$today
                )
                
                ScheduleItemViewDay(
                    days: self.days.dropFirst(7).sorted {
                        $0.id < $1.id
                    },
                    currentIndex: self.$currentIndex,
                    today: self.$today
                )
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack {
                if self.model.schedule.isEmpty {
                    Text("Test")
                } else {
                    ForEach(
                        self.model.schedule.filter { $0.day == self.currentIndex },
                        id: \.self
                    ) { item in
                        ScheduleItemView(item: item)
                    }
                }
            }
        }.onAppear {
            self.model.fetchShedule(accountId: self.accountId, groupId: self.groupId)
            
            let calendar = Calendar.init(identifier: .gregorian)
            let date = calendar.date(
                from: calendar.dateComponents(
                    [
                        .yearForWeekOfYear,
                        .weekOfYear
                    ],
                    from: Date()
                )
            )
            
            self.today = Int(ScheduleView.MONTH_DAY_FORMATTER.string(from: Date()))!
            
            
            self.days = (1...14).map { index in
                let date = calendar.date(byAdding: .day, value: index, to: date!)!
                let day = Int(ScheduleView.MONTH_DAY_FORMATTER.string(from: date))!
                
                if self.today == day {
                    self.currentIndex = index
                }
                
                return WeekDay(
                    id: index,
                    day: day,
                    name: ScheduleView.WEEK_DAY_FORMATTER.string(from: date)
                )
            }
        }
    }
}
