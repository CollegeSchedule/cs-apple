import SwiftUI

enum AuthenticationItem: CaseIterable {
    case empty
    case succes
    case notFound
    case activated
    
    var image: AnyView {
        switch self {
        case .empty:
            return EmptyView().eraseToAnyView()
            
        case .succes:
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
            }.eraseToAnyView()
        }
    }
}
