import SwiftUI
import Combine

struct ListComponentSeeAllView<T: Codable & Hashable, Content: View>: View {
    var data: [T]
    var title: String
    var content: (_ item: T) -> Content
    var navigation: ((_ item: T) -> Content)?
    var action: (_ item: T) -> Void
    
    init(
        _ data: [T],
        title: String,
        @ViewBuilder content: @escaping (_ item: T) -> Content,
        navigation: ((_ item: T) -> Content)? = nil,
        action: @escaping ((_ item: T) -> Void)
    ) {
        self.data = data
        self.title = title
        self.content = content
        self.navigation = navigation
        self.action = action
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 100), spacing: 20), count: 2), spacing: 0) {
                ForEach(self.data, id: \.hashValue) { item in
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
            }.padding(.horizontal)
        }.navigationTitle(LocalizedStringKey(self.title))
    }
    
    private func item(_ item: T) -> some View {
        self.content(item)
            .foregroundColor(.invertedDefaultColor)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
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
            .padding(.top, 20)
            .eraseToAnyView()
    }
}
