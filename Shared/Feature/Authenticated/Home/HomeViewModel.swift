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
                .filter { $0 }
                .flatMap { _ -> AnyPublisher<APIResult<CollectionMetaResponse<ScheduleSubjectEntity>>, Never> in
                    return self.performGetOperation(
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
                    self.isRefreshing = false
                    
                    if case let .success(content) = result {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.homeStatus = content.items
                        }
                    }
                })
                .store(in: &self.bag)
        }
    }
}
