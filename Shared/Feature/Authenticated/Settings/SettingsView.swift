import SwiftUI

struct SettingsView: View {
    @State
    var sections: [SettingsSection] = [
        .init(
            header: "Приложение",
            items: [
                .init(
                    icon: "lightbulb.fill",
                    title: "Внешний вид",
                    color: .purple,
                    view: SettingsAppearanceView().eraseToAnyView()
                ),
                .init(
                    icon: "globe",
                    title: "Язык",
                    color: .orange,
                    view: SettingsAppearanceView().eraseToAnyView()
                )
            ]
        ),
        
        .init(
            header: "Тех. Поддержка",
            items: [
                .init(
                    icon: "heart.fill",
                    title: "Написать отзыв",
                    color: .green,
                    view: SettingsAppearanceView().eraseToAnyView()
                ),
                .init(
                    icon: "envelope.fill",
                    title: "Связаться с разработчиком",
                    color: .blue,
                    view: SettingsAppearanceView().eraseToAnyView()
                ),
                .init(
                    icon: "house.fill",
                    title: "О приложении",
                    color: .pink,
                    view: SettingsAppearanceView().eraseToAnyView()
                )
            ]
        )
    ]
    
    var body: some View {
        List {
            ForEach(self.sections, id: \.header) { section in
                Section(header: Text(section.header)) {
                    ForEach(section.items, id: \.title) { item in
                        NavigationLink(
                            destination: item.view.navigationTitle(item.title)
                        ) {
                            Label {
                                Text(item.title)
                            } icon: {
                                Image(systemName: item.icon)
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
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    struct SettingsSection {
        let header: String
        let items: [SettingsItem]
        
        struct SettingsItem {
            let icon: String
            let title: String
            let color: Color
            let view: AnyView
        }
    }
}
