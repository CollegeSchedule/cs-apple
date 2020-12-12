import SwiftUI
import SDWebImageSwiftUI

struct AuthenticationItemView: View {
    @Binding
    var item: AccountStatusResult
    
    var body: some View {
        if self.item == AccountStatusResult.empty {
            EmptyView()
        } else {
            VStack(spacing: 12) {
                self.image()
                
                Text(LocalizedStringKey(self.text()))
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private func image() -> AnyView {
        guard case let .success(content) = self.item,
              !content.active,
              content.avatar != nil else {
            return Image(systemName: "person.circle.fill")
                .font(.system(size: 96))
                .eraseToAnyView()
        }
        
        return WebImage(url: URL(string: content.avatar!)!)
            .font(.system(size: 96))
            .clipShape(Circle())
            .eraseToAnyView()
    }
    
    private func text() -> String {
        guard case let .success(content) = self.item else {
            // MARK: - Move to localization
            
            return "authentication.not_Found"
        }
        
        return content.print
    }
}
