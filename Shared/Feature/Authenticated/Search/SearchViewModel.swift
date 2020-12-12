import Foundation
import Combine
import SwiftUI

class PaginationListData<T: Hashable&Codable>: ObservableObject {
    @Published
    var items: APIResult<[ListViewItem<T>]> = .loading
    
    @Published
    var isOut: Bool = false
    
    @Published
    var page: Int = 0
}

extension SearchView {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.accountService)
        private var accountService: AccountService
        
        @Environment(\.groupService) 
        private var groupService: GroupService
        
        @Published
        var searchBar: SearchBar = .init()
        
        @Published
        var teachers: PaginationListData<AccountEntity> = .init()
        
        @Published
        var groups: PaginationListData<GroupEntity> = .init()
        
        private var countTeachers = 30
        private var countGroups = 30
        
        override init() {
            super.init()
            
            self.searchBar.$text
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .flatMap {
                    Publishers.CombineLatest(
                        self.performGetOperation(
                            networkCall: self.accountService.get(
                                offset: 0,
                                limit: 30,
                                search: $0
                            )
                        ),
                        
                        self.performGetOperation(
                            networkCall: self.groupService.get(
                                offset: 0,
                                limit: 30,
                                search: $0
                            )
                        )
                    )
                }
                .sink { result in
                    guard case let .success(teachers) = result.0,
                          case let .success(groups) = result.1 else {
                        self.teachers.items = .empty
                        self.groups.items = .empty
                        
                        return
                    }
                    
                    self.teachers.items = .success(teachers.items.enumerated().map { (index, item) in
                        ListViewItem(id: index, item: item)
                        
                    })
                    
                    self.groups.items = .success(groups.items.enumerated().map { (index, item) in
                        ListViewItem(id: index, item: item)
                    })
                    self.objectWillChange.send()
                }
                .store(in: &self.bag)
            
            self.teachers.$page
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .filter { $0 != -1 }
                .flatMap { page -> AnyPublisher<APIResult<CollectionMetaResponse<AccountEntity>>, Never> in
                    return self.performGetOperation(
                        networkCall: self.accountService.get(
                            offset: page * 30,
                            limit: 30
                        )
                    )
                }
                .sink { result in
                    guard case let .success(new) = result,
                          case let .success(old) = self.teachers.items else {
                        
                        return
                    }
                    
//                    if old.count < 30 {
//                        self.teachers.isOut = true
//                    }
                    
                    self.teachers.items = .success(old + new.items.map { item in
                        self.objectWillChange.send()
                        self.countTeachers += 1
                        return ListViewItem(id: self.countTeachers, item: item)
                    })
                }
                .store(in: &self.bag)
            
            self.groups.$page
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .filter { $0 != -1 }
                .flatMap { page -> AnyPublisher<APIResult<CollectionMetaResponse<GroupEntity>>, Never> in
                    return self.performGetOperation(
                        networkCall: self.groupService.get(
                            offset: page * 30, limit: 30
                        )
                    )
                }
                .sink {
                    guard case let .success(new) = $0,
                          case let .success(old) = self.groups.items else {
                        
                        return
                    }
                    
//                    if old.count < 30 {
//                        self.groups.isOut = true
//                    }
                    
                    self.groups.items = .success(old + new.items.map { item in
                        self.objectWillChange.send()
                        self.countGroups += 1
                        return ListViewItem(id: self.countGroups, item: item)
                    })
                }
                .store(in: &self.bag)
        }
    }
}
