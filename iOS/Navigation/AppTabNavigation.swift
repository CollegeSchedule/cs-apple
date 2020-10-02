import SwiftUI

struct AppTabNavigation: View {
    @State
    private var selection: NavigationItem = .settings
    
    var body: some View {
        TabView(selection: self.$selection) {
            ForEach(NavigationItem.allCases, id: \.self) { item in
                NavigationView {
                    item.view
                        .navigationTitle(item.title)
                }
                .tabItem {
                    Label(item.title, systemImage: item.icon)
                        .accessibility(label: Text(item.title))
                }
                .tag(item)
            }
        }
    }
}
