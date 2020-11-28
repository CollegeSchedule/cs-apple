import SwiftUI

struct SearchView: View {
    @ObservedObject
    private var model: SearchView.ViewModel = .init()
    
    var body: some View {
        SearchContentView()
//            .add(self.model.searchBar)
    }
}

struct SearchContentView: View {
    @ObservedObject
    private var model: SearchView.ViewModel = .init()
    
    @State
    var friends: [Int] = .init(0...100)
    
    var body: some View {
        ScrollView {
            if case APIResult.empty = self.model.teachers {
                Text("Hello")
            } else if case let APIResult.success(content) = self.model.teachers {
                if content.items.isEmpty {
                    Text("EMPTY ASF")
                } else {
                    Text("Data: \(content.items[0].firstName)")
                }
            } else if case APIResult.error = self.model.teachers {
                Text("Error")
            }
            
            ListView(self.model.teach, title: "authenticated.search.teachers") { item in
                Text(item.firstName)
                    .eraseToAnyView()
            } navigation: { item in
                SearchViewNavigationItem(account: item)
                    .eraseToAnyView()
        
            }
            ListView(self.friends, title: "authenticated.search.groups") { item in
                RoundedRectangle(cornerRadius: 12)
                    .overlay(
                        Text("item: \(item)")
                            .foregroundColor(.black)
                            .padding()
                    )
                    .eraseToAnyView()
            } navigation: { item in
                Text("navigation: \(item)")
                    .eraseToAnyView()
            }
        }
    }
}
