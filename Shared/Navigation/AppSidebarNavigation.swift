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
//        .onAppear(perform: self.toggleSidebar)
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
    
    struct Pocket: View {
        var body: some View {
            Text("Test")
        }
    }
    
    private func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp
            .keyWindow?
            .firstResponder?
            .tryToPerform(
                #selector(NSSplitViewController.toggleSidebar(_:)),
                with: nil
            )
        #endif
    }
}
