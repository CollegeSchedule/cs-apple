import SwiftUI
import Combine

struct ListComponentView<T: Hashable & Codable, Content: View>: View {
    var data: [T]
    
    let title: String
    let divider: Bool
    
    let content: (_ item: T) -> Content
    var navigation: ((_ item: T) -> Content)?
    var action: (_ item: T) -> Void
    
    init(
        _ data: [T],
        title: String,
        divider: Bool,
        @ViewBuilder content: @escaping (_ item: T) -> Content,
        navigation: ((_ item: T) -> Content)? = nil,
        action: @escaping ((_ item: T) -> Void)
    ) {
        self.data = data
        self.title = title
        self.divider = divider
        self.content = content
        self.navigation = navigation
        self.action = action
    }
    
    var body: some View {
        if !self.data.isEmpty {
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
                            destination: ListComponentSeeAllView(
                                self.data, title: self.title, content: self.content, navigation: self.navigation, action: self.action
                            )
                        )
                    }
                }.padding([.horizontal, .top])
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHGrid(rows: .init(repeating: .init(.flexible(), spacing: 0), count: 3), spacing: 0) {
                        ForEach(self.data.prefix(30), id: \.hashValue) { item in
                            if self.navigation != nil {
                                NavigationLink(destination: self.navigation!(item)) {
                                    self.item(item)
                                }
                            } else {
                                Button(action: {
                                    self.action(item)
                                }) {
                                    self.item(item)
                                }
                            }
                        }
                    }.frame(height: 200)
                }
            }
        }
    }
    
    private func item(_ item: T) -> some View {
        self.content(item)
            .foregroundColor(.invertedDefaultColor)
            .frame(width: 170)
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.accentColor))
            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .applyIf(self.navigation != nil) {
                $0.contextMenu(menuItems: {
                    Button(action: {
                        self.action(item)
                    }) {
                        Text("Добавить в избранное")
                    }
                })
            }
            .padding(.leading, 20)
            .eraseToAnyView()
    }
}
