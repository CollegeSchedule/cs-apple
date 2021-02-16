import Foundation
import Combine
import SwiftUI
import UserNotifications

extension CollegeSchedule {
    class ViewModel: BaseViewModel, ObservableObject {
        @Environment(\.accountMeService) private var service: AccountMeService
        
        @Published("last_version") private var version: String = "Unknown"
        @Published("last_build") private var build: String = "Unknown"
        
        @Published("on_boarding_complete") private var onBoardingComplete: Bool = false
        @Published var account: APIResult<AccountMeEntity> = .loading
        
        override init() {
            super.init()
            
            self.version = UIApplication.appVersion ?? "Unknown"
            self.build = UIApplication.appBuild ?? "Unknown"
        }
        
        func fetch() {
            self.performGetOperation(networkCall: self.service.get())
                .subscribe(on: Scheduler.background)
                .receive(on: Scheduler.main)
                .assign(to: \.account, on: self)
                .store(in: &self.bag)
        }
    }
    
    class SettingsModel: BaseViewModel, ObservableObject {
        @Published("lesson_show_empty") var lessonShowEmpty: Bool = true
        @Published("lesson_show_sort") var lessonShowSort: Bool = false
        @Published("lesson_show_time") var lessonShowTime: Bool = true
        
        deinit {}
    }
}
