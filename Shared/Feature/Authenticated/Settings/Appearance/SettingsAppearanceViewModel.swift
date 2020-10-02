import Foundation
import Combine

extension SettingsAppearanceView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Published("settings_appearance_is_system")
        var isSystemAppearance: Bool = true
        
        @Published("settings_appearance_current")
        var currentAppearance: Int = 0
    }
}
