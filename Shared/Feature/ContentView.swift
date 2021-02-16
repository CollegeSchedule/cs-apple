import SwiftUI

struct ContentView: View {
    @ObservedObject private var state: CollegeSchedule.ViewModel = .init()
    @State private var selection: NavigationItem = .home
    
    var body: some View {
        TabView(selection: self.$selection) {
            ForEach(NavigationItem.allCases.filter { $0 != .schedule }, id: \.self) { item in
                NavigationView {
                    item.view
                        .navigationTitle(LocalizedStringKey(item.title))
                        .navigationBarTitleDisplayMode(.inline)
                }
                .tabItem {
                    Label(LocalizedStringKey(item.title), systemImage: item.icon)
                }
                .tag(item)
            }
        }
    }
}
