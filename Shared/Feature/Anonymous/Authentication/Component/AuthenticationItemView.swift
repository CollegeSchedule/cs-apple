import SwiftUI
import SDWebImageSwiftUI

struct AuthenticationItemView: View {
    @Binding
    var item: AccountStatusResult
    
    var body: some View {
        guard case let .success(content) = self.item, !content.active else {
            return EmptyView().eraseToAnyView()
        }

        return VStack(spacing: 12) {
            if content.avatar != nil {
                WebImage(url: URL(string: content.avatar!)!)
                    .resizable()
                    .frame(width: 128, height: 128, alignment: .center).clipShape(Circle()).eraseToAnyView()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 128, height: 128, alignment: .center).eraseToAnyView()
            }
        
            Text(content.print).font(.largeTitle).bold().multilineTextAlignment(.center)
        }.eraseToAnyView()
    }
}
