import SwiftUI

struct SearchView: View {
    @ObservedObject
    private var model: SearchView.ViewModel = .init()
    
    var body: some View {
        ScrollView {
            APIResultView(
                status: self.$model.teachers.items,
                title: "authenticated.search.teachers"
            ) { item in
                ListView(
                    item,
                    title: "authenticated.search.teachers",
                    page: self.$model.teachers.page
                ) { item in
                    Text(item.print)
                        .foregroundColor(.white)
                        .eraseToAnyView()
                } navigation: { item in
                    ScheduleView(accountId: item.id)
                        .navigationTitle(item.print)
                        .eraseToAnyView()
                } navigationContent: { item in
                    Text(item.print)
                        .foregroundColor(.generalTextColor)
                        .eraseToAnyView()
                }
            }
            APIResultView(
                status: self.$model.groups.items,
                title: "authenticated.search.groups"
            ) { item in
                ListView(
                    item,
                    title: "authenticated.search.groups",
                    page: self.$model.groups.page
                ) { item in
                    Text(item.print!)
                        .foregroundColor(.white)
                        .eraseToAnyView()
                } navigation: { item in
                    ScheduleView(groupId: item.id)
                        .navigationTitle(item.print!)
                        .eraseToAnyView()
                } navigationContent: { item in
                    Text(item.print!)
                        .foregroundColor(.generalTextColor)
                        .eraseToAnyView()
                }
            }
        }.add(self.model.searchBar)
    }
}
