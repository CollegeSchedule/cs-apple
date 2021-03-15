import Foundation
import Combine
import SwiftUI

extension SearchComponentView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.accountService) private var accountService: AccountService
        @Environment(\.groupService) private var groupService: GroupService
        
        @Published var teachers: APIResult<CollectionMetaResponse<AccountEntity>> = .loading
        @Published var groups: APIResult<CollectionMetaResponse<GroupEntity>> = .loading
        
        @Published var searchBar: SearchBar = .init()
        
        override init() {
            super.init()
            
            self.searchBar.$text
                //.removeDuplicates()
                .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                .subscribe(on: Scheduler.main).receive(on: Scheduler.main)
                .sink { result in
                    self.fetchTeachers(search: result)
                    self.fetchGroups(search: result)
                }
                .store(in: &self.bag)
        }
        
        private func fetchTeachers(search: String) {
            self.performGetOperation(networkCall: self.accountService.get(offset: 0, limit: 150, search: search, scope: ["teacher"]))
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .assign(to: \.teachers, on: self)
                .store(in: &self.bag)
        }
        
        private func fetchGroups(search: String) {
            self.performGetOperation(networkCall: self.groupService.get(offset: 0, limit: 150, search: search))
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .assign(to: \.groups, on: self)
                .store(in: &self.bag)
        }
    }
}
