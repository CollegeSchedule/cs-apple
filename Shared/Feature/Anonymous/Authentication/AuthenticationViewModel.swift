import Foundation
import SwiftUI
import Combine

extension AuthenticationView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.authenticationService)
        private var service: AuthenticationService
        
        // MARK: - Input
        @Published
		var mail: String = "hello@whywelive.me"
        @Published
		var password: String = "12345678"
        
        // MARK: - Output
        @Published
        var isValid: Bool = false
        
		@Published
		var isActive: Bool = false
        
        @Published
        var item: AuthenticationItem = .empty
        
        @Published
        var sheetItem: AuthenticationScanerItem?
        
        @Published
		var status: APIResult<AuthenticationEntity> = .empty
        
        @Published
        var scanner: APIResult<AuthenticationScannerEntity> = .empty
        
        // MARK: - Private logic
        private var isMailValidPublisher: AnyPublisher<Bool, Never> {
            self.$mail
                .debounce(for: 0.2, scheduler: Scheduler.main)
                .map { result in
                    result.isEmail()
                }
                .eraseToAnyPublisher()
        }
        
        private var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
            self.$password
                .debounce(for: 0.2, scheduler: Scheduler.main)
                .map { result in
                    result.count >= 8
                }
                .eraseToAnyPublisher()
        }
        
        override init() {
            super.init()
            
            Publishers.CombineLatest(
                self.isMailValidPublisher,
                self.isPasswordValidPublisher
            )
            .map { (mail, password) in
                return mail && password
            }
            .assign(to: \.self.isValid, on: self)
            .store(in: &self.bag)
        }
        
        func login() {
            self.performGetOperation(
                networkCall: self.service.login(
                    mail: self.mail,
                    password: self.password
                )
            )
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .assign(to: \.self.status, on: self)
            .store(in: &self.bag)
        }
        
        func statusScanner(token: String) {
            self.performGetOperation(
                networkCall: self.service.scanner(token: token)
            )
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .map { result in
                if case APIResult.empty = result {
                    self.item = .empty
                } else if case let APIResult.success(content) = result {
                    if content.active {
                        self.item = .activated
                    } else {
                        self.item = .success
                    }
                } else if case APIResult.error = result {
                    self.item = .notFound
                }
                return result
            }
            .assign(to: \.self.scanner, on: self)
            .store(in: &self.bag)
        }
    }
}
