import SwiftUI
import Combine

struct ScheduleListSeeAllView<T: Codable & Hashable, Content: View>: View {
    var data: [T]
    var title: String
    var content: (_ item: T) -> Content
    var navigation: (_ item: T) -> Content
    
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
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 100), spacing: 20), count: 2), spacing: 20) {
                ForEach(self.data, id: \.hashValue) { item in
                    NavigationLink(destination: self.navigation(item)) {
                        self.content(item)
                            .foregroundColor(.invertedDefaultColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .padding(.vertical)
                            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.accentColor))
                    }
                }
            }.padding(.horizontal)
        }.navigationTitle(LocalizedStringKey(self.title))
    }
}
