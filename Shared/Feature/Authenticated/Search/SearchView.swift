import SwiftUI

struct SearchView: View {
    @ObservedObject
    var searchBar: SearchBar = SearchBar()
    
    var body: some View {
        ScrollView {
            Text("Gonna be here")
            
            Text(LocalizedStringKey("authenticated.tab.settings"))
        }.add(self.searchBar)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
