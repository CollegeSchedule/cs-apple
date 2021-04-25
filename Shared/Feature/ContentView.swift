import SwiftUI

struct ContentView: View {
    @State var navigation: NavigationItem = .schedule
    
    var body: some View {
        TabView(selection: self.$navigation) {
            ForEach(NavigationItem.allCases, id: \.self) { item in
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
