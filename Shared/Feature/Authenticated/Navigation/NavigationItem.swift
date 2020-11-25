import Foundation
import SwiftUI

enum NavigationItem: CaseIterable {
    case home
    case settings
    
    var title: String {
        switch self {
        case .home: return "Дневник"
        case .settings: return "authenticated.tab.settings"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .settings: return "gear"
        }
    }
    
    var view: AnyView {
        switch self {
        case .home: return HomeView().eraseToAnyView()
        case .settings: return SettingsView().eraseToAnyView()
        }
    }
}
