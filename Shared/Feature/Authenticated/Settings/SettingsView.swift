import SwiftUI

struct SettingsView: View {
    @Environment(\.agent)
    var model: Agent
    @State
    private var isActive: Bool = false
    
    @State
    var sections: [SettingsSection] = [
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
                )
            ]
        ),
        .init(
            header: "authenticated.settings.tech_support",
            items: [
                .init(
                    icon: "heart.fill",
                    title: "authenticated.settings.feedback",
                    color: .green,
                    view: SettingsAppearanceView().eraseToAnyView()
                ),
                .init(
                    icon: "envelope.fill",
                    title: "authenticated.settings.contact",
                    color: .blue,
                    link: "https:/vk.com"
                ),
                .init(
                    icon: "house.fill",
                    title: "authenticated.settings.about",
                    color: .pink,
                    view: SettingsAboutAppView().eraseToAnyView()
                )
            ]
        )
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
            Section {
                Button(action: {
                    self.isActive = true
                }) {
                    Label(LocalizedStringKey("authenticated.settings.log_out"), image: "globe")
                        .labelStyle(TitleOnlyLabelStyle())
                        .foregroundColor(.red)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .alert(isPresented: self.$isActive, content: {
            Alert(
                title: Text(LocalizedStringKey("authenticated.settings.log_out")),
                message: Text(LocalizedStringKey("authenticated.settings.message_log_out")),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text(LocalizedStringKey("authenticated.settings.log_out")),
                    action: {
                        AgentKey.defaultValue.isAuthenticated = false            
                    }
                )
            )
        })
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
    
    struct SettingsSection {
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
