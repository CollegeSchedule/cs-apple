import SwiftUI
import SDWebImageSwiftUI
import MarkdownUI

struct HomeView: View {
    @EnvironmentObject private var state: CollegeSchedule.ViewModel
    @EnvironmentObject private var settings: CollegeSchedule.SettingsModel
    @ObservedObject private var model: HomeView.ViewModel = .init()
    
    @State var isProfilePresented: Bool = false

    var body: some View {
        APIResultView(result: self.$model.news, empty: { Text("No news :(") }) { result in
            List(result, id: \.id) { item in
                Markdown(Document(item.content))
            }.listStyle(InsetGroupedListStyle())
        }
        .navigationBarItems(trailing: Button(action: {
            self.isProfilePresented = true
        }) {
            self.profileIcon
        })
        .modifier(BackgroundModifier(color: .scheduleSectionListColor))
        .sheet(isPresented: self.$isProfilePresented, content: {
            ProfileView(account: self.$state.account, isPresented: self.$isProfilePresented)
        })
    }
    
    private var profileIcon: some View {
        guard case let .success(content) = self.state.account, content.account.avatar != nil else {
            return Image(systemName: "person.circle.fill")
                .resizable().frame(width: 32, height: 32, alignment: .center).eraseToAnyView()
        }
        
        return WebImage(url: URL(string: content.account.avatar!)!)
            .resizable()
            .placeholder {
                Image(systemName: "person.circle.fill")
                    .resizable().frame(width: 32, height: 32, alignment: .center).eraseToAnyView()
            }
            .frame(width: 32, height: 32, alignment: .center).clipShape(Circle())
            .eraseToAnyView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Приоритеты")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(UIColor.systemGray5))
                    
                    Text("Молодые профессионалы")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.orange)
        .cornerRadius(12)
        .padding()
    }
}
