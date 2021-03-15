import SwiftUI
import SPAlert

struct SearchComponentView: View {
    @EnvironmentObject private var settings: CollegeSchedule.SettingsModel
    
    @ObservedObject private var model: SearchComponentView.ViewModel = .init()
    
    var navigationAllowed: Bool
    
    init(navigationAllowed: Bool = true) {
        self.navigationAllowed = navigationAllowed
    }
    
    var body: some View {
        APIResultView2(first: self.$model.teachers, second: self.$model.groups, empty: {
            ErrorView(animation: "not_found", title: "Мы ничего не нашли", description: "Попробуйте скорректировать свой запрос")
        }) { (teachers, groups) in
            ScrollView {
                ListComponentView(teachers.items, title: "authenticated.search.teachers", divider: false, content: { item in
                    Text(item.print).foregroundColor(.defaultColor).eraseToAnyView()
                }, navigation: self.navigationAllowed ? { item in
                    ScheduleComponentView(accountId: item.id, mode: .teacher).navigationTitle(item.print).eraseToAnyView()
                } : nil, action: { item in
                    SPAlert.present(title: "Выбран преподаватель: \(item.print)", preset: .done)
                    self.settings.scheduleId = item.id
                    self.settings.scheduleTitle = item.print
                })
                
                ListComponentView(groups.items, title: "authenticated.search.groups", divider: true, content: { item in
                    Text(item.print!).foregroundColor(.defaultColor).eraseToAnyView()
                }, navigation: self.navigationAllowed ? { item in
                    ScheduleComponentView(groupId: item.id, mode: .student).navigationTitle(item.print!).eraseToAnyView()
                } : nil, action: { item in
                    SPAlert.present(title: "Выбрана группа: \(item.print!)", preset: .done)
                    self.settings.scheduleTitle = item.print!
                    self.settings.scheduleId = -item.id
                })
            }
        }.add(self.model.searchBar)
    }
}
