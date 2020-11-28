import Foundation
import SwiftUI

enum NavigationItem: CaseIterable {
    case home
    case search
    case settings
    
    var title: String {
        switch self {
        case .home: return "authenticated.tab.home"
        case .search: return "authenticated.tab.search"
        case .settings: return "authenticated.tab.settings"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        case .settings: return "gear"
        }
    }
    
    var view: AnyView {
        switch self {
        case .home: return HomeView().eraseToAnyView()
        case .search: return SearchView().eraseToAnyView()
        case .settings: return SettingsView().eraseToAnyView()
        }
    }
}
