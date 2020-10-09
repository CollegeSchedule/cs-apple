import SwiftUI
import Combine

@main
struct CollegeSchedule: App {
    @ObservedObject
    var agent: Agent = AgentKey.defaultValue
    
    @ObservedObject
    var state: AppState = .init()
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
            
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
//            Text("H: \((self.horizontalSizeClass == nil).description)")
//            Text("V: \((self.verticalSizeClass == nil).description)")
            
            self.currentScene()
                .sheet(isPresented: self.$state.onBoarding) {
                    OnBoardingView(isPresented: self.$state.onBoarding)
                }
                
                .environmentObject(self.state)
                .preferredColorScheme(
                    !self.state.isSystemAppearance
                        ? (
                            (self.state.currentAppearance != 0)
                                ? ColorScheme.dark
                                : ColorScheme.light
                            )
                        : ColorScheme.init(.unspecified)
                )
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
