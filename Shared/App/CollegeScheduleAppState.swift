import Foundation
import Combine
import SwiftUI

extension CollegeSchedule {
    class ViewModel: BaseViewModel, ObservableObject {
        @Published("last_version") private var version: String = "Unknown"
        @Published("last_build") private var build: String = "Unknown"
    
        override init() {
            super.init()
            
            self.version = UIApplication.appVersion ?? "Unknown"
            self.build = UIApplication.appBuild ?? "Unknown"
        }
    }
    
    class SettingsModel: BaseViewModel, ObservableObject {
        @Published("lesson_show_empty") var lessonShowEmpty: Bool = true
        @Published("lesson_show_sort") var lessonShowSort: Bool = false
        @Published("lesson_show_time") var lessonShowTime: Bool = true
    }
}
