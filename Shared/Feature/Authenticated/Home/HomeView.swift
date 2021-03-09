import SwiftUI
import SDWebImageSwiftUI
import MarkdownUI

struct HomeView: View {
    @EnvironmentObject private var state: CollegeSchedule.ViewModel
    @EnvironmentObject private var settings: CollegeSchedule.SettingsModel
    @ObservedObject private var model: HomeView.ViewModel = .init()
    
    var body: some View {
        APIResultView(result: self.$model.news, empty: { Text("No news :(") }) { result in
            List {
                ForEach(result.items, id: \.id) { item in
                    Section(header: Text(item.name)) {
                        Markdown(Document(item.content))
                    }
                }
                
            }.listStyle(InsetGroupedListStyle())
        }.modifier(BackgroundModifier(color: .scheduleSectionListColor))
    }
}
