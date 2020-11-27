import Foundation
import Combine

extension CollegeSchedule {
    class ViewModel: BaseViewModel, ObservableObject {
        @Published("settings_appearance_is_system")
        var isSystemAppearance: Bool = true
        
        @Published("settings_appearance_current")
        var currentAppearance: Int = 0
        
        @Published("token")
        var token: String = ""
        
        @Published
        var account: AccountEntity? = nil
        
        func fetchAccount() {
            
        }
    }
}
