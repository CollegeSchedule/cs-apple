import Foundation
import Combine
import SwiftUI

extension SearchView {
	class ViewModel: BaseViewModel, ObservableObject {
		@Environment(\.accountService)
		var service: AccountService
		
		@Published
		var teachers: APIResult<CollectionMetaResponse<AccountEntity>> = .empty
		
		override init() {
			super.init()
			
			self.get()
		}
		
		func get() {
			self.performGetOperation(
				networkCall: self.service.get()
			)
			.subscribe(on: Scheduler.background)
			.receive(on: Scheduler.main)
			.assign(to: \.self.teachers, on: self)
			.store(in: &self.bag)
		}
	}
}
