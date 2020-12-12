import SwiftUI
import Combine

struct ListView<T: Hashable&Codable, Content: View>: View {
    
    var data: [ListViewItem<T>]
    let title: String
    let content: (_ item: T) -> Content
    let navigation: (_ item: T) -> Content
    
    @Binding
    var page: Int
    
    init(
        _ data: [ListViewItem<T>],
        title: String,
        page: Binding<Int>,
        @ViewBuilder content: @escaping (_ item: T) -> Content,
        @ViewBuilder navigation: @escaping (_ item: T) -> Content
    ) {
        self.data = data
        self._page = page
        self.title = title
        self.content = content
        self.navigation = navigation
    }
    
    var body: some View {
        VStack {
            if self.data.isEmpty {
                EmptyView()
            } else {
                VStack{
                    Divider()
                    HStack {
                        Text(LocalizedStringKey(self.title))
                            .font(.system(size: 22, weight: .bold))
                        
                        Spacer()
                        
                        NavigationLink(
                            LocalizedStringKey("authenticated.search.all"),
                            destination:
                                ScheduleListSeeAllView(
                                    self.data,
                                    page: self.$page,
                                    content: self.content,
                                    navigation: self.navigation
                                )
                        )
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
                        ForEach(self.data.filter { result in
                            result.id < 30
                        },
                        id: \.hashValue
                        ) { item in
                            NavigationLink(destination: self.navigation(item.item)) {
                                self.content(item.item)
                                    .frame(width: 170)
                                    .padding(.vertical)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .foregroundColor(.accentColor)
                                    )
                                    .padding(.horizontal)
                            }
                        }
                    }.frame(height: 200)
                }
            }
        }
    }
}
