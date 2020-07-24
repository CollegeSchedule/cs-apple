import SwiftUI

struct AppSidebarNavigation: View {
    @State
    private var selection: Set<NavigationItem> = [.news]
    
    #if os(macOS)
    private let items: [NavigationItem] = [.news, .marks, .schedule, .search]
    #else
    private let items: [NavigationItem] = NavigationItem.allCases
    #endif
    
    var body: some View {
        NavigationView {
            #if os(macOS)
            self.sidebar.frame(minWidth: 100, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
            #else
            self.sidebar
            #endif
            
            Text("Content List: \(self.selection.first)").frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if self.selection.first == .news {
                Text("Select a Smoothie")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .toolbar { Spacer() }
            }
        }
    }
    
    var sidebar: some View {
        List(self.items, id: \.self, selection: self.$selection) { item in
            NavigationLink(destination: Text(item.title)) {
                Label(item.title, systemImage: item.icon)
            }.accessibility(label: Text(item.title)).tag(item)
        }.listStyle(SidebarListStyle()).navigationTitle(Text("CollegeSchedule"))
    }
    
    struct Pocket: View {
        var body: some View {
            Text("Test")
        }
    }
}
