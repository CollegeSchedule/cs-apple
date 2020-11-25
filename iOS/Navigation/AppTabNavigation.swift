import SwiftUI

struct AppTabNavigation: View {
    @State
    private var selection: NavigationItem = .home
    
    var body: some View {
        TabView(selection: self.$selection) {
            ForEach(NavigationItem.allCases, id: \.self) { item in
                if item == .settings {
                    NavigationView {
                        item.view
                            .navigationTitle(
                                LocalizedStringKey(item.title)
                            )
                    }
                    .tabItem {
                        Label(
                            LocalizedStringKey(item.title),
                            systemImage: item.icon
                        )
                    }
                    .tag(item)
                } else {
                    item.view
                        .navigationTitle(
                            LocalizedStringKey(item.title)
                        )
                        .tabItem {
                            Label(
                                LocalizedStringKey(item.title),
                                systemImage: item.icon
                            )
                        }
                        .tag(item)
                }
            }
        }
    }
}
