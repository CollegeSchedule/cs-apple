import SwiftUI

struct OnBoardingPageView: View {
    var item: OnBoardingItem
    
    var body: some View {
        VStack {
            VStack {
                Text(self.item.title)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                
                Text(self.item.description)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
            }
            
            Spacer()
            
            Image("OnBoarding\(self.item.image)Page")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Spacer()
        }
    }
}
