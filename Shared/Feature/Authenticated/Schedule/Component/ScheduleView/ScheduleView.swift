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
        UITableView.appearance().backgroundColor = UIColor(Color.scheduleSectionListColor)
    }
    
    var body: some View {
        ZStack {
            Color.scheduleSectionListColor.ignoresSafeArea()
            VStack(spacing: 0) {
                Picker("Выбор недели", selection: self.$model.selection) {
                    Text(LocalizedStringKey("authenticated.schedule.current")).tag(0)
                    Text(LocalizedStringKey("authenticated.schedule.next")).tag(1)
                }
                .padding(.horizontal)
                .pickerStyle(SegmentedPickerStyle())
                if self.model.lessonsTime.item.isEmpty {
                    Text(LocalizedStringKey("authenticated.schedule.no_lessons"))
                        .padding()
                } else {
                    List {
                        ForEach(self.days, id: \.id) { day in
                            if self.model.lessonsTime.item.filter { result in
                                result.day == day.id
                            }.count == 0 { } else {
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
                                    if self.isTeacher {
                                        ScheduleItemViewLessons(
                                            day: day,
                                            item: self.model.lessonsTime.item
                                                .filter {
                                                    $0.day == day.id
                                                }.sorted {
                                                    $0.sort < $1.sort
                                                },
                                            isTeacher: self.isTeacher,
                                            weekdays: self.model.lessonsTime.weekdays
                                        )
                                    } else {
                                        ScheduleItemViewLessons(
                                            day: day,
                                            item: self.model.lessonsTime.item
                                                .filter {
                                                    $0.day == day.id
                                                },
                                            isTeacher: self.isTeacher,
                                            weekdays: self.model.lessonsTime.weekdays
                                        )
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
                Spacer()
            }
        }
    }
}
