import SwiftUI

@main
struct CollegeSchedule: App {
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            #if APPCLIP
            Text("APP CLIP")
            #else
            ContentView()
            #endif
        }
    }
}
