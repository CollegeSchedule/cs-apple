import SwiftUI
import Combine

@main
struct CollegeSchedule: App {
    @ObservedObject
    var model: CollegeSchedule.ViewModel = .init()
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            self.currentScene()
                .environmentObject(Agent())
                .sheet(isPresented: .constant(false)) {
                    OnBoardingView()
                }
        }
    }
    
    private func currentScene() -> AnyView {
        if true {
            return AnyView(AuthenticationView())
        } else {
            return AnyView(ContentView())
        }
    }
}

extension CollegeSchedule {
    class ViewModel: ObservableObject {
        @AppStorage("on_boarding_launch")
        var onBoarding: Bool = true
        
        @AppStorage("token")
        var token: String = ""
    }
}



