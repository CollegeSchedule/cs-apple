import Foundation
import SwiftUI
import Combine

extension AuthenticationView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.authenticationService)
        private var service: AuthenticationService
        
        // MARK: - Input
        @Published
		var mail: String = "test@whywelive.me"
		
        @Published
		var password: String = "fucktest"
		
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
//                .debounce(for: 0.2, scheduler: Scheduler.main)
                .map { result in
                    result.isEmail()
                }
                .eraseToAnyPublisher()
        }
        
        private var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
            self.$password
//                .debounce(for: 0.2, scheduler: Scheduler.main)
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
            
            Publishers.CombineLatest(
                self.isMailValidPublisher,
                self.isPasswordValidPublisher
            )
            .map { (mail, password) in
                guard case .success = self.account else {
                    return mail && password
                }
                
                return password
            }
            .assign(to: \.self.isValid, on: self)
            .store(in: &self.bag)
            
            self.accountStatusPublisher
                .sink { result in
                    self.mail = ""
                    self.password = ""
                    self.account = result
                }
                .store(in: &self.bag)
        }
        
        func login() {
            self.performGetOperation(
                networkCall: {
                    guard case .success = self.account else {
                        return self.service.login(
                            mail: self.mail,
                            password: self.password
                        )
                    }
                    
                    return self.service.login(
                        token: self.accountCode,
                        password: self.password
                    )
                }()
            )
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .print()
            .assign(to: \.self.status, on: self)
            .store(in: &self.bag)
        }
    }
}
