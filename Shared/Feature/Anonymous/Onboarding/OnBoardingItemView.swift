import SwiftUI

struct OnBoardingItemView: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(spacing: 20) {
            HStack(alignment: .center) {
                Image(systemName: self.icon).font(.system(size: 48))
            }.frame(minWidth: 50, maxWidth: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(self.title).bold()
                Text(self.description).opacity(0.8)
            }
            
            Spacer()
        }
    }
}
