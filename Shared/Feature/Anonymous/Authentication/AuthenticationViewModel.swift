import Foundation
import Combine

class AuthenticationViewModel: BaseViewModel, ObservableObject {
    // MARK: - Input
    @Published var mail: String = ""
    @Published var password: String = ""
    
    // MARK: - Output
    @Published var isValid: Bool = false
    
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
        .map { mail, password in
            return mail && password
        }
        .assign(to: \.self.isValid, on: self)
        .store(in: &self.bag)
    }
}
