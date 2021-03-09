import Combine
import SwiftUI

extension HomeView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.newsService)
        private var service: NewsService
        
        @Published
        var news: APIResult<CollectionMetaResponse<NewsEntity>> = .loading
        
        override init() {
            super.init()
            
            self.performGetOperation(networkCall: self.service.get())
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .assign(to: \.self.news, on: self)
                .store(in: &self.bag)
        }
    }
}
