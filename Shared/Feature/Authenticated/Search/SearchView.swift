import SwiftUI

struct SearchView: View {
    @ObservedObject
    var searchBar: SearchBar = SearchBar()
    
    @State
    var friends: [Int] = .init(0...100)
    
    var body: some View {
        ScrollView {
            ListView(self.friends, title: "Teachers") { item in
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
            ListView(self.friends, title: "Groups") { item in
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
        }.add(self.searchBar)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
