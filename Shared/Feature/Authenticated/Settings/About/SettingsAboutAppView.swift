import SwiftUI

struct SettingsAboutAppView: View {
    @State
    var updates: [String] = [
        "Обновление",
        "Обновление",
        "Обновление",
        "Обновление"
    ]
    
    var body: some View {
        List {
            Section(header: HStack {
                Text(LocalizedStringKey("authenticated.settings.about.verstion"))
                Spacer()
                Text(UIApplication.appVersion!)
            }) {
                ForEach(self.updates, id: \.self) { item in
                    Text(item)
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}


