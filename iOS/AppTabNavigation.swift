import SwiftUI

struct AppTabNavigation: View {
    enum TabNavigation {
        case news
        case marks
        case schedule
        case search
        case settings
    }
    
    @State
    private var selection: TabNavigation = .news
    
    var body: some View {
        TabView(selection: self.$selection) {
            NavigationView {
                Text("News")
            }.tabItem {
                Label("News", systemImage: "house")
                    .accessibility(label: Text("News"))
            }
            
            NavigationView {
                Text("Marks")
            }.tabItem {
                Label("Marks", systemImage: "house")
                    .accessibility(label: Text("Marks"))
            }
            
            NavigationView {
                Text("Schedule")
            }.tabItem {
                Label("Schedule", systemImage: "house")
                    .accessibility(label: Text("Schedule"))
            }
            
            NavigationView {
                Text("Search")
            }.tabItem {
                Label("Search", systemImage: "house")
                    .accessibility(label: Text("Search"))
            }
            
            NavigationView {
                Text("Settings")
            }.tabItem {
                Label("Settings", systemImage: "house")
                    .accessibility(label: Text("Settings"))
            }
        }
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
