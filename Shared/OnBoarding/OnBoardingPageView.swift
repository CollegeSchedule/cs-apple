import SwiftUI

struct OnBoardingPageView: View {
    var item: OnBoardingItem
    
    var body: some View {
        VStack {
            Text(self.item.title)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 60)
                .font(.custom(
                        .fontSFCompactRoundedBold,
                        size: 26,
                        relativeTo: .largeTitle))
            
            Text(self.item.description)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                .padding(.bottom, 60)
                .font(.custom(
                        .fontSFCompactRoundedRegular,
                        size: 16,
                        relativeTo: .body))
            
            VStack(alignment: .center) {
                Image("OnBoarding\(self.item.image)Page")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            
            Spacer()
        }
    }
}

struct OnBoardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPageView(
            item: OnBoardingItem(
                id: 1,
                title: "Welcome to Momotaro UI Kit",
                description: "The best UI Kit for your next health and fitness project.",
                image: "First"
            )
        )
    }
}
