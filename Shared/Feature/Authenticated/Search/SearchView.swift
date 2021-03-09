import SwiftUI

struct SearchView: View {
    @ObservedObject private var model: SearchView.ViewModel = .init()
    
    var body: some View {
        APIResultView2(first: self.$model.teachers, second: self.$model.groups, empty: {
            Text("Empty")
        }) { (teachers, groups) in
            ScrollView {
                ListView(teachers.items, title: "authenticated.search.teachers", divider: false) { item in
                    Text(item.print).foregroundColor(.defaultColor).eraseToAnyView()
                } navigation: { item in
                    ScheduleComponentView(accountId: item.id, mode: .teacher).navigationTitle(item.print).eraseToAnyView()
                }
                
                ListView(groups.items, title: "authenticated.search.groups", divider: true) { item in
                    Text(item.print!).foregroundColor(.defaultColor).eraseToAnyView()
                } navigation: { item in
                    ScheduleComponentView(groupId: item.id, mode: .student).navigationTitle(item.print!).eraseToAnyView()
                }
            }
        }.add(self.model.searchBar)
    }
}
