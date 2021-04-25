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
            ContentView().environmentObject(self.state).environmentObject(self.settings)
        }
    }
}
