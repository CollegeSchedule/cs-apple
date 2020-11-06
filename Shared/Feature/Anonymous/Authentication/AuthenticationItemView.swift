import SwiftUI

struct AuthenticationItemView: View {
    let item: AuthenticationItem
    
	var body: some View{
        self.image()
	}
    
    private func image() -> AnyView {
        switch self.item {
        case .empty:
            return EmptyView().eraseToAnyView()
        case .success:
            return Image(systemName: "person.circle.fill")
                       .resizable()
                       .frame(
                           minWidth: 0,
                           maxWidth: 133,
                           minHeight: 0,
                           maxHeight: 113
                        )
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
                    Image(systemName: "person.crop.circle.fill.badge.exclamationmark")
                        .resizable()
                        .frame(
                            minWidth: 0,
                            maxWidth: 133,
                            minHeight: 0,
                            maxHeight: 113
                        )
                    Text("Аккаунт уже зарегистрирован")
                        .font(.system(size: 32, weight: .semibold, design: .default))
                        .multilineTextAlignment(.center)
            }.eraseToAnyView()
        }
    }
}
