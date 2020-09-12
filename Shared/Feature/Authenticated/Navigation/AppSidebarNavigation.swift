import SwiftUI

struct AppSidebarNavigation: View {
    @State
    var selection: NavigationItem? = .news
    
    var body: some View {
        NavigationView {
            self.sidebar
                                    
            NewsView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
    
    var sidebar: some View {
        List {
            self.mainSection
        }.listStyle(SidebarListStyle()).navigationTitle(Text("CollegeSchedule"))
    }
    
    var mainSection: some View {
        ForEach(NavigationItem.allCases, id: \.self) { item in
            NavigationLink(destination: item.view) {
                Label(
                    item.title,
                    systemImage: item.icon
                )
            }.tag(item).accessibility(label: Text(item.title))
        }
    }
}