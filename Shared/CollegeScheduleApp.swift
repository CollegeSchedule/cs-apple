import SwiftUI

@main
struct CollegeSchedule: App {
    @AppStorage("on_boarding")
    var onBoarding: Bool = false
    
    @AppStorage("token")
    var token: String = ""
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            if !self.onBoarding && false {
                OnBoardingView()
            } else if self.token.isEmpty {
                AuthenticationView()
            } else {
                ContentView()
            }
        }
    }
}
