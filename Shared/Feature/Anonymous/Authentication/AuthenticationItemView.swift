import SwiftUI
import SDWebImageSwiftUI

struct AuthenticationItemView: View {
    let item: AuthenticationItem
	let text: String
	let url: String = "https://source.unsplash.com/random"
    
	var body: some View{
        self.image()
	}
    
    private func image() -> AnyView {
        switch self.item {
        case .empty:
            return EmptyView().eraseToAnyView()
        case .success:
			return VStack{
				if self.url == "" {
					Image(systemName: "person.circle.fill")
						.resizable()
						.frame(
							minWidth: 0,
							maxWidth: 113,
							minHeight: 0,
							maxHeight: 113
						)
				} else {
					WebImage(url: URL(string: self.url)!)
						.resizable()
						.clipShape(Circle())
						.frame(
							minWidth: 0,
							maxWidth: 113,
							minHeight: 0,
							maxHeight: 113
						)
				}
				Text(self.text)
					.font(.system(size: 32, weight: .semibold, design: .default))
					.multilineTextAlignment(.center)
			}
			.eraseToAnyView()
        case .notFound:
            return VStack{
                    Image(systemName: "person.crop.circle.fill.badge.exclamationmark")
                        .resizable()
                        .frame(
                            minWidth: 0,
                            maxWidth: 133,
                            minHeight: 0,
                            maxHeight: 113
                        )
                    Text("Аккаунт не найден")
                        .font(.system(size: 32, weight: .semibold, design: .default))
                        .multilineTextAlignment(.center)
            }.eraseToAnyView()
        case .activated:
            return VStack{
				if self.url != "" {
					WebImage(url: URL(string: self.url)!)
						.resizable()
						.clipShape(Circle())
						.frame(
							minWidth: 0,
							maxWidth: 113,
							minHeight: 0,
							maxHeight: 113
						)
				} else {
					Image(systemName: "person.crop.circle.fill.badge.exclamationmark")
						.resizable()
						.frame(
							minWidth: 0,
							maxWidth: 133,
							minHeight: 0,
							maxHeight: 113
						)
				}
                    Text("Аккаунт уже зарегистрирован")
                        .font(.system(size: 32, weight: .semibold, design: .default))
                        .multilineTextAlignment(.center)
            }.eraseToAnyView()
        }
    }
}
