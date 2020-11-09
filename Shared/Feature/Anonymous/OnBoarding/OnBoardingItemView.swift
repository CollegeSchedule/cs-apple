import SwiftUI

struct OnBoardingItemView: View {
    let item: OnBoardingView.Item
    
    var body: some View {
        HStack {
            Image(systemName: self.item.icon)
                .foregroundColor(.accentColor)
                .font(.system(size: 36))
            
            VStack(alignment: .leading) {
                Text(self.item.title)
                    .font(.headline)
                    
                Text(self.item.description)
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .light))
            }.padding(.leading)
        }.frame(maxWidth: 500)
    }
}

