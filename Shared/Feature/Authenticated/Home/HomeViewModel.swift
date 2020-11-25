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
                            teacherId: 50,
                            studentId: nil
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
                        
                        print("empty")
                    }
                                        
                    if case let .success(content) = result {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.homeStatus = content.items
                    }
                        print("succes")
                    }
                    
                })
                .store(in: &self.bag)
            
        }
    }
}
