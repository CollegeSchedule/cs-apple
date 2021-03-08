import Combine
import SwiftUI

extension HomeView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.newsService)
        private var service: NewsService
        
        @ObservedObject
        private var model: AuthenticationView.ViewModel = .init()
        
        @Published
        var news: APIResult<[NewsEntity]> = .loading
        
        override init() {
            super.init()
            
            self.performGetOperation(networkCall: self.service.get())
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .map { (content: APIResult<CollectionMetaResponse<NewsEntity>>) -> APIResult<[NewsEntity]> in
                    if case let .success(content) = content {
                        print("GOT \(content.items.count)")
                        
                        return APIResult.success(content.items)
                    }
                    
                    return APIResult.loading
                }
                .assign(to: \.self.news, on: self)
                .store(in: &self.bag)
        }
    }
}
