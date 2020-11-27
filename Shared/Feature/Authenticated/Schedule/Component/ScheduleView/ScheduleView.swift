//
//  ScheduleView.swift
//  iOS
//
//  Created by admin on 27.11.2020.
//

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
                // MARK: - Remove duplicate
                HStack {
                    ForEach(self.days.dropLast(7), id: \.id) { item in
                        Spacer()
                        
                        Button(action: {
                            self.currentIndex = item.id
                        }) {
                            VStack {
                                Text(item.name)
                                Text(item.day.description)
                                    .frame(width: 32, height: 32)
                                    .background(self.dayBackgroundView(item))
                            }
                        }
                        
                        
                        Spacer()
                    }
                }
                HStack {
                    ForEach(self.days.dropFirst(7), id: \.id) { item in
                        Spacer()
                        
                        Button(action: {
                            self.currentIndex = item.id
                        }) {
                            VStack {
                                Text(item.name)
                                Text(item.day.description)
                                    .frame(width: 32, height: 32)
                                    .background(self.dayBackgroundView(item))
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack {
                if self.model.schedule.filter { $0.day == self.currentIndex }.count == 0 {
                    ForEach(0..<1) { _ in
                        Text("Hui")
                    }
                } else {
                    ForEach(
                        self.model.schedule.filter { $0.day == self.currentIndex },
                        id: \.self
                    ) { item in
                        HomeItemView(item: item)
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
    
    private func dayBackgroundView(_ day: WeekDay) -> AnyView {
        if day.id == self.currentIndex {
            return Circle().foregroundColor(.blue).eraseToAnyView()
        } else if day.day == self.today {
            return Circle().stroke().foregroundColor(.blue).eraseToAnyView()
        } else {
            return Circle().foregroundColor(.clear).eraseToAnyView()
        }
    }
}
