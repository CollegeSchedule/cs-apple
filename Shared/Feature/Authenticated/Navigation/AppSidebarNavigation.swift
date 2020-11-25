import SwiftUI

struct AppSidebarNavigation: View {
    @State
    var selection: NavigationItem? = .home
    
    var body: some View {
        NavigationView {
            self.sidebar
                                    
            HomeView()
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
            NavigationLink(destination: item.view.navigationTitle(LocalizedStringKey(item.title))) {
                Label(
                    LocalizedStringKey(item.title),
                    systemImage: item.icon
                )
            }.tag(item).accessibility(label: Text(item.title))
        }
    }
}
