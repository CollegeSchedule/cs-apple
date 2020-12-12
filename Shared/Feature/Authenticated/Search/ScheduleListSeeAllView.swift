import SwiftUI
import Combine

struct ScheduleListSeeAllView<T: Codable&Hashable, Content: View>: View {
    
    @Binding
    var page: Int
    
    var data: [ListViewItem<T>]
    var content: (_ item: T) -> Content
    var navigation: (_ item: T) -> Content
    
    init(
        _ data: [ListViewItem<T>],
        page: Binding<Int>,
        @ViewBuilder content: @escaping (_ item: T) -> Content,
        @ViewBuilder navigation: @escaping (_ item: T) -> Content
    ) {
        self.data = data
        self.content = content
        self.navigation = navigation
        self._page = page
    }
    
    var body: some View {
        VStack {
            List(self.data, id: \.item) { item in
                NavigationLink(destination: self.navigation(item.item)) {
                    self.content(item.item)
                        .onAppear {
                            if self.data.count - 5 == item.id {
                                self.page += 1
                            }
                        }
                }
            }.listStyle(InsetGroupedListStyle())
        }.navigationTitle("Аккаунты")
    }
}
