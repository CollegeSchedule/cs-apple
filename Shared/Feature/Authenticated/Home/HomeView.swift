import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @EnvironmentObject private var state: CollegeSchedule.ViewModel
    @EnvironmentObject private var settings: CollegeSchedule.SettingsModel
    
    @State var isProfilePresented: Bool = false

    var body: some View {
        APIResultView(result: self.$state.account, empty: { EmptyView() }) { account in
//            ScrollView {
//                VStack {
//                    CardView()
//                }
//            }
            ScheduleComponentView(
                accountId: account.account.id,
                groupId: nil,
                mode: account.account.label == .teacher ? .teacher : .student
            )
            .navigationBarItems(trailing: Button(action: {
                self.isProfilePresented = true
            }) {
                if account.account.avatar == nil {
                    Image(systemName: "person.circle.fill")
                        .resizable().frame(width: 32, height: 32, alignment: .center).eraseToAnyView()
                } else {
                    WebImage(url: URL(string: account.account.avatar ?? "http://localhost")!)
                        .resizable()
                        .placeholder {
                            Image(systemName: "person.circle.fill")
                                .resizable().frame(width: 32, height: 32, alignment: .center).eraseToAnyView()
                        }
                        .frame(width: 32, height: 32, alignment: .center).clipShape(Circle())
                }
            })
        }
        .modifier(BackgroundModifier(color: .scheduleSectionListColor))
        .sheet(isPresented: self.$isProfilePresented, content: {
            ProfileView(account: self.$state.account, isPresented: self.$isProfilePresented)
        })
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
