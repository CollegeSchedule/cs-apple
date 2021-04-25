import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: CollegeSchedule.SettingsModel
    @Environment(\.agent) private var model: Agent
    
    @State
    private var sections: [SettingsSection] = [
//        .init(
//            header: "Основное",
//            items: [
//                .init(
//                    icon: "house.fill",
//                    title: "Уведомления",
//                    color: .green,
//                    view: SettingsNotificationsView().eraseToAnyView()
//                ),
//            ]
//        ),
        .init(
            header: "authenticated.settings.app",
            items: [
                .init(
                    icon: "lightbulb.fill",
                    title: "authenticated.settings.appearance",
                    color: .purple,
                    view: SettingsAppearanceView().eraseToAnyView()
                ),
                .init(
                    icon: "globe",
                    title: "authenticated.settings.language",
                    color: .orange,
                    execute: {
                        UIApplication.shared.open(
                            URL(
                                string: UIApplication.openSettingsURLString
                            )!
                        )
                    }
                ),
//                .init(
//                    icon: "laptopcomputer",
//                    title: "authenticated.settings.contact",
//                    color: .blue,
//                    link: "https://collegeschedule.ru:2096"
//                ),
            ]
        ),

//        .init(
//            header: "authenticated.settings.tech_support",
//            items: [
//                .init(
//                    icon: "laptopcomputer",
//                    title: "authenticated.settings.contact",
//                    color: .blue,
//                    link: "https://collegeschedule.ru:2096"
//                ),
//
//                .init(
//                    icon: "house.fill",
//                    title: "authenticated.settings.about",
//                    color: .pink,
//                    view: SettingsAboutAppView().eraseToAnyView()
//                ),
//            ]
//        )
    ]
    
    var body: some View {
        List {
            ForEach(self.sections, id: \.header) { section in
                Section(header: Text(LocalizedStringKey(section.header))) {
                    ForEach(section.items, id: \.title) { item in
                        self.item(item)
                    }
                }
            }
//            
//            if self.settings.isDeveloper {
//                Section(header: Text("Developer Mode")) {
//                    Text("Hello, r u Developer?")
//                }
//            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    private func item(_ item: SettingsSection.SettingsItem) -> AnyView {
        if item.view != nil {
            return NavigationLink(
                destination: item.view?.navigationTitle(LocalizedStringKey(item.title))
            ) {
                self.label(item)
            }.eraseToAnyView()
        } else if item.execute != nil {
            return Button(action: item.execute!) {
                self.label(item)
            }.eraseToAnyView()
        } else if item.link != nil {
            return Link(destination: URL(string: item.link!)!){
                self.label(item)
            }
            .eraseToAnyView()
        }
        
        return EmptyView().eraseToAnyView()
    }
    
    private func label(_ item: SettingsSection.SettingsItem) -> AnyView {
        return Label {
            Text(LocalizedStringKey(item.title))
                .foregroundColor(Color.generalTextColor)
        } icon: {
            if item.icon != nil {
                Image(systemName: item.icon!)
                    .foregroundColor(.white)
                    .frame(
                        width: 32,
                        height: 32,
                        alignment: .center
                    )
                    .background(item.color)
                    .cornerRadius(8)
            }
        }
        .eraseToAnyView()
    }
    
    private struct SettingsSection {
        var header: String = ""
        let items: [SettingsItem]
        
        struct SettingsItem {
            let icon: String?
            let title: String
            let color: Color?
            
            var view: AnyView? = nil
            var execute: (() -> Void)? = nil
            var link: String? = nil
        }
    }
}
