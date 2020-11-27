import SwiftUI

struct SearchViewNavigationItem: View {
    @State
    var account: AccountEntity
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Основная информация")) {
                    HStack {
                        Text("Должность")
                        Spacer()
                        Text("Директор")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Телефон")
                        Spacer()
                        Link("2255044", destination: URL(string: "tel:2255044")!)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Почта")
                        Spacer()
                        Link("nke@nke.ru", destination: URL(string: "mailto:nke@nke.ru")!)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Сайт")
                        Spacer()
                        Link("nke.ru", destination: URL(string: "http://nke.ru")!)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Стаж работы")
                        Spacer()
                        Text("19 лет")
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: ScheduleView(accountId: self.account.id)){
                    Text("Расписание")
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
