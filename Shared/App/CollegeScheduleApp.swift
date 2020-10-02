import SwiftUI
import Combine

@main
struct CollegeSchedule: App {
    @ObservedObject
    var agent: Agent = AgentKey.defaultValue
    
    @ObservedObject
    var state: AppState = .init()
            
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            self.currentScene()
                .sheet(isPresented: self.$state.onBoarding) {
                    OnBoardingView(isPresented: self.$state.onBoarding)
                }
                .environmentObject(self.state)
                .preferredColorScheme((!self.state.isSystemAppearance) ? ((self.state.currentAppearance != 0) ? .dark : .light) : .none)
        }
    }
    private func currentScene() -> AnyView {
        if !self.agent.isAuthenticated {
            return AuthenticationView().eraseToAnyView()
        } else {
            return ContentView().eraseToAnyView()
        }
    }
}

class AppState: ObservableObject {
    @Published("settings_appearance_is_system")
    var isSystemAppearance: Bool = true
    
    @Published("settings_appearance_current")
    var currentAppearance: Int = 0
    
    @Published("on_boarding_launch")
    var onBoarding: Bool = true
    
    @Published("token")
    var token: String = ""
}

extension CollegeSchedule {
    func mod(_ isSystem: Bool, current: Int) -> ColorScheme?{
        if isSystem {
            print(isSystem.description)
            
            return ColorScheme.init(.unspecified)
        }
        else {
            print(isSystem.description)
            if (current != 0) {
                return ColorScheme.init(.dark)
            }
            else{
                return ColorScheme.init(.light)
            }
        }
    }
}
