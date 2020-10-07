import SwiftUI

struct SettingsAboutAppView: View {
    var body: some View {
        List{
            HStack{
                Text("Version")
                Spacer()
                Text("1.0")
            }
        }.listStyle(InsetGroupedListStyle())
    }
}
