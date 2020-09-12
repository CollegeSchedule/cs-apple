import Foundation
import SwiftUI

enum NavigationItem: CaseIterable {
    case news
    case marks
    case schedule
    case search
    case settings
    
    var title: String {
        switch self {
        case .news: return "Новости"
        case .marks: return "Оценки"
        case .schedule: return "Расписание"
        case .search: return "Поиск"
        case .settings: return "Настройки"
        }
    }
    
    var icon: String {
        switch self {
        case .news: return "house"
        case .marks: return "checkmark.rectangle"
        case .schedule: return "alarm"
        case .search: return "magnifyingglass"
        case .settings: return "gear"
        }
    }
    
    var view: AnyView {
        switch self {
        case .news: return NewsView().eraseToAnyView()
        case .marks: return Text("Marks").eraseToAnyView()
        case .schedule: return Text("Schedule").eraseToAnyView()
        case .search: return Text("Search").eraseToAnyView()
        case .settings: return Text("Settings").eraseToAnyView()
        }
    }
}