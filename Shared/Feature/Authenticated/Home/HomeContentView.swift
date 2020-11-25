import SwiftUI


struct WeekDay {
    let id: Int
    let day: String
    let name: String
}

struct HomeContentView: View {
    @EnvironmentObject
    var model: HomeView.ViewModel
    
    @State
    var days: [WeekDay] = []
    
    @State
    var currentWeekDay: Int = 1
    
    @State
    var currentPage: Int = 1
    
    var body: some View {
        VStack {
            //            ScrollView(.horizontal, showsIndicators: false) {
            //                HStack {
            //                    ForEach(self.days, id: \.id) { item in
            //                        VStack {
            //                            Text(item.name)
            //                            Text(item.day)
            //                        }
            //                        .padding(8)
            //                        .cornerRadius(12)
            //                        .onTapGesture {
            //                            self.currentWeekDay = item.id
            //                        }
            //                    }
            //                }
            //            }
            
//            Text(self.days.description)
            TabView(selection: self.$currentPage) {
//                WeekView(days: self.days.filter{ $0.id > 7 }, currentWeekDay: self.$currentWeekDay)
//                WeekView(days: self.days.filter{ $0.id > 7 }, currentWeekDay: self.$currentWeekDay)
                HStack{
                    ForEach(self.days.filter{ $0.id < 8 }, id: \.id) { item in
                        Spacer()
                        VStack {
                            Text(item.name)
                            Text(item.day)
                        }
                        .padding(8)
                        .cornerRadius(12)
                        .onTapGesture {
                            self.currentWeekDay = item.id
                        }
                        Spacer()
                    }
                }
                HStack{
                    ForEach(self.days.filter{ $0.id > 7 }, id: \.id) { item in
                        Spacer()
                        VStack {
                            Text(item.name)
                            Text(item.day)
                        }
                        .padding(8)
                        .cornerRadius(12)
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
            self.model.isRefreshing = true
            
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
            
            self.days = (1...14).map { index in
                let day = calendar.date(byAdding: .day, value: index, to: date)!
                
                return WeekDay(
                    id: index,
                    day: MONTH_DAY_FORMATTER.string(from: day),
                    name: WEEK_DAY_FORMATTER.string(from: day)
                )
            }
        }
    }
    
    struct WeekView: View {
        @State
        var days: [WeekDay]
        @Binding
        var currentWeekDay: Int
        
        var body: some View {
            HStack{
                Text(self.days.count.description)
                ForEach(self.days, id: \.id) { item in
                    
                    
                    VStack {
                        Text(item.name)
                        Text(item.day)
                    }
                    .padding(8)
                    .cornerRadius(12)
                    .onTapGesture {
                        self.currentWeekDay = item.id
                    }

                }
            }
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
