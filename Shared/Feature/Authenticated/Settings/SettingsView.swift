import SwiftUI

struct SettingsView: View {
	@Environment(\.agent)
	var model: Agent
	
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
                    execute: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
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
                    link: "https:/vk.com"
                ),
                .init(
                    icon: "house.fill",
                    title: "О приложении",
                    color: .pink,
                    view: SettingsAboutAppView().eraseToAnyView()
                )
            ]
        ),
		.init(
			items: [
				.init(
					icon: "globe",
					title: "Выйти",
					color: .orange,
					execute: {
						AgentKey.defaultValue.isAuthenticated = false
					}
				)
			]
		)
		
    ]
    
    var body: some View {
        List {
            ForEach(self.sections, id: \.header) { section in
				Section(header: Text(section.header)) {
                    ForEach(section.items, id: \.title) { item in
                        self.item(item)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    private func item(_ item: SettingsSection.SettingsItem) -> AnyView {
        if item.view != nil {
            return NavigationLink(
                destination: item.view?.navigationTitle(item.title)
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
            Text(item.title)
				.foregroundColor(item.textColor ?? Color("GeneralTextColor"))
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
//		.labelStyle(item.icon == nil ? DefaultLabelStyle() as! LabelStyle: IconOnlyLabelStyle())
		.eraseToAnyView()
    }
    
    struct SettingsSection {
        var header: String = ""
        let items: [SettingsItem]
        
        struct SettingsItem {
            let icon: String?
            let title: String
            let color: Color?
			var textColor: Color? = nil
            
            var view: AnyView? = nil
            var execute: (() -> Void)? = nil
            var link: String? = nil
        }
    }
}
