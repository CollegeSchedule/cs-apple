import Foundation
import Combine

class AuthenticationViewModel: BaseViewModel, ObservableObject {
    // MARK: - Input
    @Published var mail: String = "hello@whywelive.me"
    @Published var password: String = "12345678"
    
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
    
    public func login() {
        self.performGetOperation(
            databaseQuery: self.database(),
            networkCall: AuthenticationService().login(
                mail: self.mail,
                password: self.password
            )
        )
        .subscribe(on: Scheduler.background)
        .receive(on: Scheduler.main)
        .sink(receiveValue: { result in
            print("got result: \(result)")
        })
        .store(in: &self.bag)
    }
    
    public func me() {
        self.performGetOperation(
            databaseQuery: self.meDatabase(),
            networkCall: AuthenticationService().test()
        )
        .subscribe(on: Scheduler.background)
        .receive(on: Scheduler.main)
        .sink(receiveValue: { result in
            print("got result: \(result)")
        })
        .store(in: &self.bag)
    }
    
    func database() -> AnyPublisher<Authentication, Never> {
        return Deferred {
            Future { promise in }
        }.eraseToAnyPublisher()
    }
    
    func meDatabase() -> AnyPublisher<AccountMeEntity, Never> {
        return Deferred {
            Future { promise in }
        }.eraseToAnyPublisher()
    }
    
}
