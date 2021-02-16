import Foundation
import Combine
import SwiftUI
import SPAlert

extension ProfilePasswordView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.accountMeService)
        private var service: AccountMeService
        
        @Published
        var old: String = ""
        
        @Published
        var new: String = ""
        
        @Published
        var confirm: String = ""
        
        @Published
        var status: APIResult<AccountMeEntity> = .empty
        
        @Published
        var isValid: Bool = false
        
        private var isOldValidPublisher: AnyPublisher<Bool, Never> {
            self.$old
                .debounce(for: 0.2, scheduler: Scheduler.main)
                .map { result in
                    result.count >= 8
                }
                .eraseToAnyPublisher()
        }
        
        private var isNewPublisher: AnyPublisher<Bool, Never> {
            self.$new
                .debounce(for: 0.2, scheduler: Scheduler.main)
                .map { result in
                    result.count >= 8
                }
                .eraseToAnyPublisher()
        }
        
        private var isConfirmPublisher: AnyPublisher<Bool, Never> {
            self.$confirm
                .debounce(for: 0.2, scheduler: Scheduler.main)
                .map { result in
                    result.count >= 8
                }
                .eraseToAnyPublisher()
        }
        
        override init() {
            super.init()
            
            Publishers.CombineLatest3(
                self.isOldValidPublisher,
                self.isNewPublisher,
                self.isConfirmPublisher
            )
            .map { (old, new, confirm) in
                old && new && confirm
            }
            .assign(to: \.self.isValid, on: self)
            .store(in: &self.bag)
        }
        
        func execute() {
            if self.old == self.new {
                return SPAlert.present(
                    title: "Old and new passwords are same!",
                    preset: .error
                )
            }
            
            if self.new != self.confirm {
                return SPAlert.present(
                    title: "New and confirm password aren't the same!",
                    preset: .error
                )
            }
            
            self.performGetOperation(networkCall: self.service.changePassword(old: self.old, new: self.new))
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .assign(to: \.self.status, on: self)
                .store(in: &self.bag)
        }
    }
}
