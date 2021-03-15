import SwiftUI

struct ErrorView: View {
    var animation: String?
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            if self.animation != nil {
                LottieView(content: self.animation!).frame(height: 250, alignment: .center)
            }
            
            Text(self.title).font(.title).padding(.vertical).multilineTextAlignment(.center)
            Text(self.description).multilineTextAlignment(.center)
        }.padding()
    }
}
