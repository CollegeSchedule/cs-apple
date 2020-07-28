import SwiftUI

struct AppSidebarNavigation: View {
    @State
    var selection: NavigationItem? = .news
    
    #if os(macOS)
    private let items: [NavigationItem] = [.news, .marks, .schedule]
    #else
    private let items: [NavigationItem] = [.news, .marks, .schedule, .search, .settings]
    #endif
    
    var body: some View {
        NavigationView {
            self.sidebar
                                    
            NewsView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
    
    var sidebar: some View {
        List {
            #if os(macOS)
            Section(header: Text("CollegeSchedule")) {
                self.mainSection
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            }
            #else
            self.mainSection
            #endif
        }.listStyle(SidebarListStyle()).navigationTitle(Text("CollegeSchedule"))
    }
    
    var mainSection: some View {
        ForEach(self.items, id: \.self) { item in
            NavigationLink(destination: item.view) {
                Label(
                    item.title,
                    systemImage: item.icon
                )
            }.tag(item).accessibility(label: Text(item.title))
        }
    }
}
