import SwiftUI

struct SearchView: View {
    @ObservedObject
    private var model: SearchView.ViewModel = .init()
    
    var body: some View {
        ScrollView {
            APIResultView(status: self.$model.teachers.items) { item in
                ListView(
                    item,
                    title: "authenticated.search.teachers",
                    page: self.$model.teachers.page
                ) { item in
                    Text(item.print)
                        .foregroundColor(.generalTextColor)
                        .eraseToAnyView()
                } navigation: { item in
                    ScheduleView(accountId: item.id)
                        .navigationTitle(item.print)
                        .eraseToAnyView()
                }
            }
            APIResultView(status: self.$model.groups.items) { item in
                ListView(
                    item,
                    title: "authenticated.search.groups",
                    page: self.$model.groups.page
                ) { item in
                    Text(item.print!)
                        .foregroundColor(.generalTextColor)
                        .eraseToAnyView()
                } navigation: { item in
                    ScheduleView(groupId: item.id)
                        .navigationTitle(item.print!)
                        .eraseToAnyView()
                }
            }
        }.add(self.model.searchBar)
    }
}
