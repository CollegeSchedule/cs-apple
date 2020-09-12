import Combine

class BaseViewModel {
    var bag: Set<AnyCancellable> = .init()
    
    func performGetOperation<T>(
        databaseQuery: AnyPublisher<T, Never>,
        networkCall: AnyPublisher<APIResult<T>, Never>
    ) -> AnyPublisher<APIResult<T>, Never> {
        let object = CurrentValueSubject<APIResult<T>, Never>(.loading)
        
        let query = databaseQuery
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .sink(receiveValue: {
                object.send(.success($0))
            })
            
        query.store(in: &self.bag)
        
        networkCall
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .sink(receiveValue: {
                query.cancel()
                
                object.send($0)
            })
            .store(in: &self.bag)
        
        return object.eraseToAnyPublisher()
    }
}
