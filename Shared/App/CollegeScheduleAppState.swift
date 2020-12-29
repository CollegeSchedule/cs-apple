import Foundation
import Combine
import SwiftUI

extension CollegeSchedule {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.accountService)
        var service: AccountService
        
        @Published("settings_appearance_is_system")
        var isSystemAppearance: Bool = true
        
        @Published("settings_appearance_current")
        var currentAppearance: Int = 0
        
        @Published("token")
        var token: String = ""
        
        @Published
        var account: AccountMeEntity? = nil
        
        func fetchAccount() {
            self.performGetOperation(
                networkCall: self.service.me()
            )
            .map { result -> AccountMeEntity? in
                if case let .success(content) = result {
                    return content
                }
                
                return nil
            }
            .assign(to: \.account, on: self)
            .store(in: &self.bag)
        }
    }
}
