import SwiftUI

struct AppTabNavigation: View {
    @State
    private var selection: NavigationItem = .settings
    
    var body: some View {
        TabView(selection: self.$selection) {
            ForEach(NavigationItem.allCases, id: \.self) { item in
                NavigationView {
                    item.view
                        .navigationTitle(LocalizedStringKey(item.title))
                }
                .tabItem {
                    Label(LocalizedStringKey(item.title), systemImage: item.icon)
                        .accessibility(label: Text(LocalizedStringKey(item.title)))
                }
                .tag(item)
            }
        }
    }
}
