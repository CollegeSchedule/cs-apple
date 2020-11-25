import SwiftUI
import Combine

extension HomeView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.scheduleSubjectService)
        private var service: ScheduleSubjectService
        
        @Published
        var isRefreshing: Bool = false
        
        override init() {
            super.init()
            
            self.$isRefreshing
                .allSatisfy { !$0 }
                .flatMap { result -> AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never> in
                    self.performGetOperation(
                        networkCall: self.service.get(
                            groupId: nil,
                            year: 2020,
                            week: 48,
                            teacherId: nil,
                            studentId: 1
                        )
                    )
                }
                .sink(receiveValue: {
                    print($0)
                    
                    self.isRefreshing = false
                })
                .store(in: &self.bag)
            
        }
    }
}
