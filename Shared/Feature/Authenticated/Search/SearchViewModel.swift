import Foundation
import Combine
import SwiftUI

extension SearchView {
	class ViewModel: BaseViewModel, ObservableObject {
		@Environment(\.accountService)
		var service: AccountService
		
		@Published
		var searchBar: SearchBar = .init()
		
		@Published
		var teachers: APIResult<CollectionMetaResponse<AccountEntity>> = .empty
        
        @Published
        var teach: [AccountEntity] = []
		
		override init() {
			super.init()
			
			self.searchBar.$text
				.debounce(for: 1, scheduler: Scheduler.main)
				.subscribe(on: Scheduler.background)
				.receive(on: Scheduler.main)
				.sink(receiveValue: {
					self.get(search: $0)
                    if case let APIResult.success(content) = self.teachers {
                        self.teach = content.items
                        print(self.teach)
                    }
				})
				.store(in: &self.bag)
			self.get()
		}
		
		func get(search: String? = nil) {
			self.performGetOperation(
				networkCall: self.service.get(
					offset: 0, limit: 30, search: search
				)
			)
			.subscribe(on: Scheduler.background)
			.receive(on: Scheduler.main)
			.assign(to: \.self.teachers, on: self)
			.store(in: &self.bag)
		}
	}
}
