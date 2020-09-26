import SwiftUI
import Combine

@main
struct CollegeSchedule: App {
    @ObservedObject
    var model: CollegeSchedule.ViewModel = .init()
    
    @Environment(\.agent)
    var agent: Agent
    
    @State
    private var isAuthenticated: Bool = false
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            self.currentScene()
                .sheet(isPresented: self.model.$onBoarding) {
                    OnBoardingView(isPresented: self.model.$onBoarding)
                }
                .onReceive(self.agent.$isAuthenticated) {
                    self.isAuthenticated = $0
                }
        }
    }
    
    private func currentScene() -> AnyView {
        if !self.isAuthenticated {
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



