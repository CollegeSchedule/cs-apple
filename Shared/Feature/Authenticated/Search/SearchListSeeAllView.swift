import SwiftUI
import Combine

struct ScheduleListSeeAllView<T: Codable & Hashable, Content: View>: View {
    @Binding
    var page: Int
    
    var data: [ListViewItem<T>]
    var title: String
    var content: (_ item: T) -> Content
    var navigation: (_ item: T) -> Content
    
    init(
        _ data: [ListViewItem<T>],
        page: Binding<Int>,
        title: String,
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
        List(self.data, id: \.item) { item in
            NavigationLink(destination: self.navigation(item.item)) {
                self.content(item.item)
                    .onAppear {
                        if self.data.count - 5 == item.id {
                            self.page += 1
                        }
                    }
            }
        }.listStyle(InsetGroupedListStyle()).navigationTitle(LocalizedStringKey(self.title))
    }
}
