import SwiftUI
import Combine

@main
struct CollegeSchedule: App {
    @ObservedObject
    private var agent: Agent = AgentKey.defaultValue
    
    @ObservedObject
    private var state: Self.ViewModel = .init()
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            self.currentScene()
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
            return ContentView()
                .onAppear(perform: self.state.fetchAccount)
                .eraseToAnyView()
        }
    }
}

