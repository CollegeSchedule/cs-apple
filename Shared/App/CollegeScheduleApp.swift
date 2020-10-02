import SwiftUI
import Combine

@main
struct CollegeSchedule: App {
    @Environment(\.agent)
    var agent: Agent
    
    @ObservedObject
    var model: CollegeSchedule.ViewModel = .init()
    
    @AppStorage("settings_appearance_current")
    var currentAppearance: Bool = true
    
    @State
    private var isAuthenticated: Bool = false
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            Text("content: \(self.currentAppearance.description)")
            Toggle("Test", isOn: self.$currentAppearance)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            
            self.currentScene()
                .sheet(isPresented: self.model.$onBoarding) {
                    OnBoardingView(isPresented: self.model.$onBoarding)
                }
                .onReceive(self.agent.$isAuthenticated) {
                    self.isAuthenticated = $0
                }
                .environment(\.colorScheme, self.currentAppearance ? .light : .dark)
        }
    }
    
    private func currentScene() -> AnyView {
        if !self.isAuthenticated {
            return AuthenticationView().eraseToAnyView()
        } else {
            return ContentView().eraseToAnyView()
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



