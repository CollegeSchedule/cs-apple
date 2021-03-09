import SwiftUI
import Combine

struct ListView<T: Hashable&Codable, Content: View>: View {
    var data: [T]
    
    let title: String
    let divider: Bool
    
    let content: (_ item: T) -> Content
    let navigation: (_ item: T) -> Content
    
    init(
        _ data: [T],
        title: String,
        divider: Bool,
        @ViewBuilder content: @escaping (_ item: T) -> Content,
        @ViewBuilder navigation: @escaping (_ item: T) -> Content
    ) {
        self.data = data
        self.title = title
        self.divider = divider
        self.content = content
        self.navigation = navigation
    }
    
    var body: some View {
        VStack {
            VStack {
                if self.divider {
                    Divider()
                }
                
                HStack {
                    Text(LocalizedStringKey(self.title)).font(.system(size: 22, weight: .bold))
                    
                    Spacer()
                    
                    NavigationLink(
                        LocalizedStringKey("authenticated.search.all"),
                        destination: ScheduleListSeeAllView(
                            self.data, title: self.title, content: self.content, navigation: self.navigation
                        )
                    )
                }
            }.padding([.horizontal, .top])
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows: .init(repeating: .init(.flexible(), spacing: 0), count: 3), spacing: 0) {
                    ForEach(self.data.prefix(30), id: \.hashValue) { item in
                        NavigationLink(destination: self.navigation(item)) {
                            self.content(item)
                                .foregroundColor(.invertedDefaultColor)
                                .frame(width: 170)
                                .padding(.vertical)
                                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.accentColor))
                                .padding(.horizontal)
                        }
                    }
                }.frame(height: 200)
            }
        }
    }
}
