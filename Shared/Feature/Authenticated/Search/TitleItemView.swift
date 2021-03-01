import SwiftUI

struct TitleItemView: View {
    var title: String
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(LocalizedStringKey(self.title))
                    .font(.system(size: 22, weight: .bold))
                Spacer()
            }
        }
        .padding([.horizontal, .top])
    }
}
