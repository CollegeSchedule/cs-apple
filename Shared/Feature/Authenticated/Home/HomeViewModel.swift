import SwiftUI
import Combine

extension HomeView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.scheduleSubjectService)
        private var service: ScheduleSubjectService
        
        @Published
        var isRefreshing: Bool = false
        @Published
        var homeStatus: [ScheduleSubjectEntity] = []
        
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
                .sink(receiveValue: { result in
                    print(result)
                    self.isRefreshing = false
                    if case .error = result {
                        print("eror")
                    }
                    
                    if case .empty = result {
                        self.homeStatus = []
                        print("empty")
                    }
                                        
                    if case let .success(content) = result {
                        self.homeStatus = content.items
                        print("succes")
                    }
                    print(self.isRefreshing)
                })
                .store(in: &self.bag)
            
        }
    }
}
