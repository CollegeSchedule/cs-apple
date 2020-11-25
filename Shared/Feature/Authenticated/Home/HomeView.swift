import SwiftUI

struct HomeView: View {
    @ObservedObject
    var model: HomeView.ViewModel = .init()
    
    var body: some View {
        VStack {
            HomeViewControllerRepresentable(
                isRefreshing: self.$model.isRefreshing
            )
            .environmentObject(self.model)
            .ignoresSafeArea()
        }
    }
}


