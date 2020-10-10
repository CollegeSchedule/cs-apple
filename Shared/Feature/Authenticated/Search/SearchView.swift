import SwiftUI

struct SearchView: View {
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
		}.add(self.model.searchBar)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
