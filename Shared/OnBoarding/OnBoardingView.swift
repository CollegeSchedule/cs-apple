import SwiftUI

struct OnBoardingView: View {
    private var items: [OnBoardingItem] = [
        OnBoardingItem(
            id: 1,
            title: "Welcome to Momotaro UI Kit",
            description: "The best UI Kit for your next health and fitness project.",
            image: "First"
        ),
        
        OnBoardingItem(
            id: 2,
            title: "Welcome to Momotaro UI Kit",
            description: "The best UI Kit for your next health and fitness project.",
            image: "Second"
        ),
        
        OnBoardingItem(
            id: 3,
            title: "Welcome to Momotaro UI Kit",
            description: "The best UI Kit for your next health and fitness project.",
            image: "Third"
        )
    ]
    
    @State
    var selection: Int = 1
    
    var body: some View {
        ZStack {
            Color
                .onBoardingBackgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView(selection: self.$selection) {
                    ForEach(self.items, id: \.self) { item in
                        OnBoardingPageView(item: item).tag(item.id)
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 8) {
                    ForEach(0..<3, id: \.self) { item in
                        Capsule()
                            .foregroundColor(
                                self.selection == item + 1
                                    ? Color.onBoardingDotSelectedColor
                                    : Color.onBoardingDotDefaultColor
                            )
                            .frame(width: 8, height: 8)
                    }
                }
                
                Button(action: {}) {
                    Text("Get Started")
                }.buttonStyle(RoundedDefaultButton()).padding(.horizontal, 20)
                
                HStack {
                    Text("Already have account?")
                        .foregroundColor(.gray)
                    
                    Button(action: {}) {
                        Text("Sign in")
                    }
                }.padding(.bottom, 20).padding(.horizontal)
            }
        }
    }
}

struct RoundedDefaultButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.custom(.fontSFCompactRoundedBold, size: 18))
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(
                configuration.isPressed
                    ? Color.white.opacity(0.5)
                    : Color.white
            )
            .listRowBackground(
                configuration.isPressed
                    ? Color.accentColor.opacity(0.5)
                    : Color.accentColor
            )
            .background(
                configuration.isPressed
                    ? Color.accentColor.opacity(0.5)
                    : Color.accentColor
            )
            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnBoardingView()
            OnBoardingView()
                .previewDevice("iPhone 11")
            OnBoardingView()
                .previewDevice("iPhone 8")
        }
    }
}
