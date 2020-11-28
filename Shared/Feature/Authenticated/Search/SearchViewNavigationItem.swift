import SwiftUI

struct SearchViewNavigationItem: View {
    @State
    var account: AccountEntity
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text(LocalizedStringKey("authenticated.search.employee.basic_information"))) {
                    HStack {
                        Text(LocalizedStringKey("authenticated.search.employee.position"))
                        Spacer()
                        Text("Директор")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(LocalizedStringKey("authenticated.search.employee.phone"))
                        Spacer()
                        Link("2255044", destination: URL(string: "tel:2255044")!)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(LocalizedStringKey("authenticated.search.employee.mail"))
                        Spacer()
                        Link("nke@nke.ru", destination: URL(string: "mailto:nke@nke.ru")!)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(LocalizedStringKey("authenticated.search.employee.website"))
                        Spacer()
                        Link("nke.ru", destination: URL(string: "http://nke.ru")!)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(LocalizedStringKey("authenticated.search.employee.work_experience"))
                        Spacer()
                        Text("19 лет")
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: ScheduleView(accountId: self.account.id)){
                    Text(LocalizedStringKey("authenticated.search.employee.schedule"))
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(
            Text(
                "\(self.account.secondName) \(self.account.firstName.prefix(1).description). \(self.account.thirdName.prefix(1).description)."
            )
        )
        .navigationBarItems(
            trailing:
                Image("direktor")
                .resizable()
                .clipShape(Circle())
                .frame(width: 32, height: 32)
        )
    }
}
