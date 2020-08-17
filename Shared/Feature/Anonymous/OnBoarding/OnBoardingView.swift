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
    
    @AppStorage("on_boarding")
    var onBoarding: Bool = false
    
    @State
    var selection: Int = 1
    
    var body: some View {
        ZStack {
            Color
                .backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView(selection: self.$selection) {
                    ForEach(self.items, id: \.self) { item in
                        OnBoardingPageView(item: item).tag(item.id)
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer()
                
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
                }.padding(10)
                
                Button(action: {
                    self.onBoarding = true
                }) {
                    Text("Get Started")
                }.rounded().padding(.horizontal, 20)
                
                Button(action: {}) {
                    HStack {
                        Text("Already have account?")
                            .foregroundColor(.gray)
                        
                        Text("Sign in")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 10)
            }
        }
    }
}
