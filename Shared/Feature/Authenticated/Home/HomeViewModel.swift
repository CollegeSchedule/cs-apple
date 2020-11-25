import SwiftUI
import Combine

extension HomeView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.scheduleSubjectService)
        private var service: ScheduleSubjectService
        
        @Published
        var isRefreshing: Bool = false
        
        @Published
        var schedule: [ScheduleSubjectEntity] = []
        
        override init() {
            super.init()
            
            self.$isRefreshing
                .filter { $0 }
                .flatMap { _ -> Publishers.CombineLatest<
                    AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never>,
                    AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never>
                > in
                    Publishers.CombineLatest(
                        self.performGetOperation(
                            networkCall: self.service.get(
                                groupId: nil,
                                year: 2020,
                                week: 48,
                                teacherId: 50,
                                studentId: nil
                            )
                        ),
                        self.performGetOperation(
                            networkCall: self.service.get(
                                groupId: nil,
                                year: 2020,
                                week: 49,
                                teacherId: 50,
                                studentId: nil
                            )
                        )
                    )
                }
                .assertNoFailure()
     
                .sink(receiveValue: { result in
                    self.isRefreshing = false
                    
                    if case let .success(first) = result.0,
                       case let .success(second) = result.1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.schedule = first.items + second.items.map { item in
                                var modified = item
                                
                                modified.day += 7
                                
                                return modified
                            }
                        }
                    }
                })
                .store(in: &self.bag)
        }
    }
}
