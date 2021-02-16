import SwiftUI
import AuthenticationServices

struct AuthenticationView: View {
    @EnvironmentObject
    private var state: CollegeSchedule.ViewModel
    
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

