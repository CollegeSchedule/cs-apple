import SwiftUI

struct ScheduleView: View {
    @ObservedObject
    private var model: ScheduleView.ViewModel
    
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
        UITableView.appearance().backgroundColor
            = UIColor(Color.scheduleSectionListColor)
    }
    
    var body: some View {
        ZStack {
            Color
                .scheduleSectionListColor
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Picker("Выбор недели", selection: self.$model.selection) {
                    Text(LocalizedStringKey("authenticated.schedule.current"))
                        .tag(0)
                    Text(LocalizedStringKey("authenticated.schedule.next"))
                        .tag(1)
                }
                .padding(.horizontal)
                .padding(.bottom, 1)
                .pickerStyle(SegmentedPickerStyle())
                if self.model.lessonsTime.item.isEmpty {
                    Spacer()
                    Text(LocalizedStringKey("authenticated.schedule.no_lessons"))
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(
                            self.model.weekDate(
                                self.model.selection == 0
                                    ? Date()
                                    : Date.DAY_IN_WEEK
                            ),
                            id: \.id
                        ) { day in
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
                                    ScheduleItemViewLessons(
                                        day: day,
                                        item: self.model.lessonsTime.item
                                            .filter {
                                                $0.day == day.id
                                            }.sorted {
                                                $0.sort < $1.sort
                                            },
                                        isTeacher: self.isTeacher,
                                        weekdays: self.$model.lessonsTime.weekdays
                                    )
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
                    }.listStyle(PlainListStyle())
                }
            }
        }
    }
}
