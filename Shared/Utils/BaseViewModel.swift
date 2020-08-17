import Combine

class BaseViewModel {
    var bag: Set<AnyCancellable> = .init()
}
