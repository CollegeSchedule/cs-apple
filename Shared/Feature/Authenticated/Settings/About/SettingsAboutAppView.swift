import SwiftUI

struct SettingsAboutAppView: View {
    var body: some View {
        List {
            HStack {
                Text("Version")
                Spacer()
                Text(UIApplication.appVersion!)
            }
        }.listStyle(InsetGroupedListStyle())
    }
}


