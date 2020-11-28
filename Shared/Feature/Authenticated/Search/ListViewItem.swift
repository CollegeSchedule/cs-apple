import SwiftUI

struct ListView<T: Hashable, Content: View>: View {
    let data: [T]
    let title: String
    let content: (_ item: T) -> Content
    let navigation: (_ item: T) -> Content

    init(
        _ data: [T],
        title: String,
        @ViewBuilder content: @escaping (_ item: T) -> Content,
        @ViewBuilder navigation: @escaping (_ item: T) -> Content
    ) {
        self.data = data
        self.title = title
        self.content = content
        self.navigation = navigation
    }
        
    var body: some View {
        VStack {
            VStack{
                Divider()
                HStack {
                    Text(LocalizedStringKey(self.title))
                        .font(.system(size: 22, weight: .bold))
                        
                    Spacer()
                    
                    NavigationLink(LocalizedStringKey("authenticated.search.all"), destination: Text(LocalizedStringKey("authenticated.search.all")))
                }
            }
            .padding([.horizontal, .top])
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(
                    rows: .init(
                        repeating: .init(
                            .flexible()
                        ),
                        count: 3
                    ),
                    spacing: 0
                ) {
                    ForEach(self.data, id: \.hashValue) { item in
                        NavigationLink(destination: self.navigation(item)) {
                            self.content(item)
                                .padding(.leading)
                        }
                    }
                }
            }
        }
    }
}
