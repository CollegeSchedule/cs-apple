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
        case .news: return AnyView(NewsView())
        case .marks: return AnyView(Text("Marks"))
        case .schedule: return AnyView(Text("Schedule"))
        case .search: return AnyView(Text("Search"))
        case .settings: return AnyView(Text("Settings"))
        }
    }
}
