import SwiftUI

struct ScheduleView: View {
    @ObservedObject
    private var model: ScheduleView.ViewModel
    
    private var days: [WeekDay] = {
        let dateInWeek = Date()
        let calendar = Calendar.init(identifier: .gregorian)
        let dayOfWeek = calendar.component(.weekday, from: dateInWeek) - 1
        let weekdays = calendar.range(of: .weekday, in: .yearForWeekOfYear, for: dateInWeek)!
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
                                to: dateInWeek
                            )!
                    )
                )
            }
    }()
    
    private var isTeacher: Bool
    
    init(
        accountId: Int? = nil,
        groupId: Int? = nil
    ) {
        self.model = .init(
            accountId: accountId,
            groupId: groupId
        )
        
        self.isTeacher = accountId != nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Picker("Выбор недели", selection: self.$model.selection) {
                Text(LocalizedStringKey("authenticated.schedule.current")).tag(0)
                Text(LocalizedStringKey("authenticated.schedule.next")).tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            APIResultView(status: self.$model.schedule) { item in
                if item.items.isEmpty {
                    Text("Пар нет")
                } else {
                    List {
                        ForEach(self.days, id: \.id) { day in
                            if item.items.filter { result in
                                result.day == day.id
                            }.count == 0 {
                                EmptyView()
                            } else {
                                Section(
                                    header:
                                        HStack {
                                            Text(LocalizedStringKey(day.name))
                                                .font(.footnote)
                                                .foregroundColor(.scheduleListSectionTextColor)
                                            Spacer()
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .background(Color.scheduleSectionListColor)
                                ) {
                                    ForEach(
                                        item.items.filter {
                                            $0.day == day.id
                                        },
                                        id: \.id
                                    ) { item in
                                        ScheduleItemView(
                                            item: item,
                                            isTeacher: self.isTeacher
                                        )
                                        .listRowBackground(Color.scheduleRowListColor)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                    }
                                }.listRowInsets(
                                    EdgeInsets(
                                        top: 0,
                                        leading: 0,
                                        bottom: 0,
                                        trailing: 0
                                    )
                                )
                            }
                        }
                    }
                }
            }
            Spacer()
        }
    }
}
