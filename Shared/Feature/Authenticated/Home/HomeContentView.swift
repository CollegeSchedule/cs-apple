import SwiftUI


struct WeekDay {
    let id: Int
    let day: Int
    let name: String
}

struct HomeContentView: View {
    @ObservedObject
    var model: HomeView.ViewModel = .init()
    
    @State
    var days: [WeekDay] = []
    
    @State
    var currentWeekDay: Int = 1
    
    @State
    var currentPage: Int = 1
    
    @State
    var today: Int = 0
    
    func dayBackgroundView(_ day: WeekDay) -> AnyView {
        if day.day == self.today {
            return Circle().stroke().foregroundColor(.blue).eraseToAnyView()
        } else if day.id == self.currentWeekDay {
            return Circle().foregroundColor(.blue).eraseToAnyView()
        } else {
            return Circle().foregroundColor(.clear).eraseToAnyView()
        }
    }
    
    var body: some View {
        VStack {
            TabView(selection: self.$currentPage) {
                HStack{
                    ForEach(self.days.dropLast(7), id: \.id) { item in
                        Spacer()
                        VStack {
                            Text(item.name)
                            Text(item.day.description)
                                .padding(4)
                                .background(self.dayBackgroundView(item))
                        }
                        
                        .onTapGesture {
                            self.currentWeekDay = item.id
                        }
                        Spacer()
                    }
                }
                HStack{
                    ForEach(self.days.dropFirst(7), id: \.id) { item in
                        Spacer()
                        VStack {
                            Text(item.name)
                            Text(item.day.description)
                                .padding(4)
                                .background(self.dayBackgroundView(item))
                        }
                        .onTapGesture {
                            self.currentWeekDay = item.id
                        }
                        Spacer()
                    }
                }
                
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack {
                ForEach(
                    self.model.schedule.filter {
                        $0.day == self.currentWeekDay
                    },
                    id: \.self
                ) { item in
                    HomeItemView(item: item)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
        }.onAppear {
            let calendar = Calendar.init(identifier: .gregorian)
            let date = calendar.date(
                from: calendar.dateComponents(
                    [
                        .yearForWeekOfYear,
                        .weekOfYear
                    ],
                    from: Date()
                )
            )!
            
            self.today = Int(MONTH_DAY_FORMATTER.string(from: Date()))!
            self.currentWeekDay = 8
            
            self.days = (1...14).map { index in
                let day = calendar.date(byAdding: .day, value: index, to: date)!
                
                return WeekDay(
                    id: index,
                    day: Int(MONTH_DAY_FORMATTER.string(from: day))!,
                    name: WEEK_DAY_FORMATTER.string(from: day)
                )
            }
            print(self.days)
        }
    }
}

let WEEK_DAY_FORMATTER: DateFormatter = {
    let formatter = DateFormatter()
    
    formatter.dateFormat = "EE"
    
    return formatter
}()

let MONTH_DAY_FORMATTER: DateFormatter = {
    let formatter = DateFormatter()
    
    formatter.dateFormat = "dd"
    
    return formatter
}()
