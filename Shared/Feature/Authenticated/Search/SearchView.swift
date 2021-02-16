import SwiftUI

struct SearchView: View {
    @ObservedObject
    private var model: SearchView.ViewModel = .init()
    
    var body: some View {
        ScrollView {
            APIResultView(result: self.$model.teachers.items, empty: { Text("") }) { item in
                ListView(item, title: "authenticated.search.teachers", page: self.$model.teachers.page) { item in
                    Text(item.print).foregroundColor(.defaultColor).eraseToAnyView()
                } navigation: { item in
                    ScheduleComponentView(accountId: item.id, mode: .teacher).navigationTitle(item.print).eraseToAnyView()
                } navigationContent: { item in
                    Text(item.print).foregroundColor(.invertedDefaultColor).eraseToAnyView()
                }
            }
            
            APIResultView(result: self.$model.groups.items, empty: { Text("") }) { item in
                ListView(item, title: "authenticated.search.groups", page: self.$model.groups.page) { item in
                    Text(item.print!).foregroundColor(.defaultColor).eraseToAnyView()
                } navigation: { item in
                    ScheduleComponentView(groupId: item.id, mode: .student).navigationTitle(item.print!).eraseToAnyView()
                } navigationContent: { item in
                    Text(item.print!).foregroundColor(.invertedDefaultColor).eraseToAnyView()
                }
            }
        }
        .add(self.model.searchBar)
    }
}

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
