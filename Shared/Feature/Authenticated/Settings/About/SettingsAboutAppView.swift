import SwiftUI

struct SettingsAboutAppView: View {
    var body: some View {
        List {
            HStack {
                Text(LocalizedStringKey("authenticated.settings.about.verstion"))
                Spacer()
                Text(UIApplication.appVersion!)
            }
        }.listStyle(InsetGroupedListStyle())
    }
}


