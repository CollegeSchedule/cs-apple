import Foundation
import SwiftUI
import Combine

extension AuthenticationView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.authenticationService)
        private var service: AuthenticationService
        
        // MARK: - Input

        #if targetEnvironment(simulator) || DEBUG
        @Published
        var mail: String = "test@collegeschedule.com"
        
        @Published
        var password: String = "testfuck"
        #else
        @Published
        var mail: String = ""
        
        @Published
        var password: String = ""
        #endif
        
        @Published
        var passwordConfirm: String = ""
        
        @Published
        var accountCode: String = ""
		
        // MARK: - Output
		// Используется для валидности введенных данных
        @Published
        var isValid: Bool = false
        
        @Published
        var account: AccountStatusResult = .empty
        
        @Published
        var sheetItem: AuthenticationScanerItem?
        
        @Published
		var status: APIResult<AuthenticationEntity> = .empty
        
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
        
        private var isPasswordConfirmValidPublisher: AnyPublisher<Bool, Never> {
            self.$passwordConfirm
                .debounce(for: 0.2, scheduler: Scheduler.main)
                .map { result in
                    result.count >= 8
                }
                .eraseToAnyPublisher()
        }
        
		private var accountStatusPublisher: AnyPublisher<
            AccountStatusResult,
            Never
        > {
			self.$accountCode
                .flatMap { result -> AnyPublisher<
                    APIResult<AuthenticationScannerEntity>,
                    Never
                > in
                    if result.isEmpty {
                        return Just(.empty).eraseToAnyPublisher()
                    }
                    
                    return self.service.scanner(token: result)
				}
				.map { result in
                    if case .error = result {
                        return .notFound
                    }
                    
                    if case .empty = result {
                        return .empty
                    }
                                        
                    guard case let .success(content) = result else {
                        return .notFound
                    }
                    
                    return .success(content)
				}
                .eraseToAnyPublisher()
		}
		
        override init() {
            super.init()
            
            Publishers.CombineLatest3(
                self.isMailValidPublisher,
                self.isPasswordValidPublisher,
                self.isPasswordConfirmValidPublisher
            )
            .map { (mail, password, passwordConfirm) in
                if case let .success(content) = self.account, !content.active {
                    return mail && password && passwordConfirm
                } else {
                    return mail && password
                }
            }
            .assign(to: \.self.isValid, on: self)
            .store(in: &self.bag)
            
            self.accountStatusPublisher
                .sink { result in
                    if case .success = result {
                        self.mail = ""
                        self.password = ""
                    }

                    self.account = result
                }
                .store(in: &self.bag)
        }
        
        func login() {
            self.performGetOperation(
                networkCall: {
                    guard case let .success(content) = self.account else {
                        return self.service.login(
                            mail: self.mail,
                            password: self.password
                        )
                    }
                    
                    if content.active {
                        return self.service.login(
                            token: self.mail,
                            password: self.password
                        )
                    } else {
                        return self.service.register(
                            token: self.accountCode,
                            mail: self.mail,
                            password: self.password
                        )
                    }
                }()
            )
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .assign(to: \.self.status, on: self)
            .store(in: &self.bag)
        }
    }
}
