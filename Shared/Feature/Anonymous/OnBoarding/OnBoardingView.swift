import SwiftUI

struct OnBoardingView: View {
    @State
    var isPresented: Bool = true
    
    private var items: [OnBoardingView.Item] = [
        .init(
            icon: "house",
            title: "Found events",
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text.  Lorem Ipsum is simply dummy text."
        ),
        .init(
            icon: "house",
            title: "Found events",
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.  Lorem Ipsum is simply dummy text.  Lorem Ipsum is simply dummy text."
        ),
        .init(
            icon: "house",
            title: "Found events",
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.  Lorem Ipsum is simply dummy text.  Lorem Ipsum is simply dummy text."
        )
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Welcome to CollegeSchedule")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                
                VStack(alignment: .center, spacing: 36) {
                    ForEach(self.items, id: \.self) { item in
                        OnBoardingItemView(item: item)
                    }
                }.padding(.top, 64).padding(.horizontal, 32)
            }
            
            Spacer()
            
            Button(action: {
                self.isPresented = false
            }) {
                Text("Continue")
            }.rounded().padding(.bottom, 60).padding(.horizontal)
        }
    }
}

extension OnBoardingView {
    struct Item: Hashable {
        let icon: String
        let title: String
        let description: String
    }
}

