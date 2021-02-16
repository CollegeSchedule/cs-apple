import SwiftUI
import Combine

@main
struct CollegeSchedule: App {
    @ObservedObject private var agent: Agent = AgentKey.defaultValue
    @ObservedObject private var state: Self.ViewModel = .init()
    @ObservedObject private var settings: Self.SettingsModel = .init()
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            self.currentScene().environmentObject(self.state).environmentObject(self.settings)
        }
    }
    
    private func currentScene() -> AnyView {
        if !self.agent.isAuthenticated {
            return AuthenticationView().eraseToAnyView()
        }
        
        return ContentView().onAppear(perform: self.state.fetch).eraseToAnyView()
    }
}
