import SwiftUI

struct NewsView: View {
    private var columns: [GridItem] = [.init(.flexible(minimum: 350))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: self.columns, spacing: 26) {
                Section(header:
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Четверг, 1 янв.".uppercased())
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color("NewsSectionDateColor"))
                            
                            Text("50 лет назад")
                                .font(.system(size: 28, weight: .bold))
                                .padding(.top, 2)
                        }
                        
                        Spacer()
                    }.padding(.bottom, -10)
                ) {
                    ForEach(0..<5, id: \.self) { item in
                        CardView()
                    }
                }
            }.padding(20)
        }.navigationBarHidden(true)
    }
}

struct CardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("NewsCardBackgroundColor"))
                .frame(minHeight: 350)
                .cornerRadius(12)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 12, y: 8)
            CardViewContent().padding(20)
        }
    }
}

struct CardViewContent: View {
    struct CardPollItem: Hashable {
        var title: String
        var value: Int
    }
    
    @State
    var items: [CardPollItem] = [
        CardPollItem(
            title: "Рома лох",
            value: 50
        ),
        CardPollItem(
            title: "SwiftUI is a modern way to declare user interfaces for any Apple platform.",
            value: 50
        ),
        CardPollItem(
            title: "SwiftUI is a modern way to declare user interfaces for any Apple platform.",
            value: 50
        ),
        CardPollItem(
            title: "SwiftUI is a modern way to declare user interfaces for any Apple platform.",
            value: 50
        )
    ]
    
    @State
    var value: Double = 100.0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Голосование")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("NewsCardTitleColor"))
                Spacer()
            }
            
            HStack {
                Text("Я не понял, кто тут мать вашу принцесса?")
                    .font(.system(size: 26, weight: .bold))
            }.padding(.top, 20)
            
        
            // - MARK: Replace ScrollView with VStack
            ScrollView() {
                ForEach(0..<self.items.count, id: \.self) { id in
                    ProgressBar(text: self.items[id].title, value: .constant(Double(self.items[id].value)))
                        .onTapGesture {
                            self.items[id].value = 70
                        }
                }
            }
            
            HStack {
                Text("Ends on Jun 4, 23:57")
                    .font(.system(size: 14))
                    .foregroundColor(Color("NewsCardBottomTitleColor"))
                
                Spacer()
                
                Text("10K votes")
                    .font(.system(size: 14))
                    .foregroundColor(Color("NewsCardBottomTitleColor"))
            }.padding(.top, 10)
        }
    }
}

struct ProgressBar: View {
    @State
    var text: String
    
    @Binding
    var value: Double
    
    var body: some View {
        ZStack {
            GeometryReader { geometryReader in
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(Color("NewsCardItemBackgroundColor"))
                    .frame(height: geometryReader.size.height)
                    
                Rectangle()
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                    .frame(
                        width: self.progress(
                            width: geometryReader.size.width
                        ),
                        height: geometryReader.size.height
                    )
                    .foregroundColor(Color("NewsCardItemForegroundColor"))
                    .animation(.easeIn)
            }
            
            HStack {
                Text(self.text)
                    .font(.system(size: 14))
                    .foregroundColor(Color("NewsCardItemTextColor"))
                    .padding(0)
                    .lineLimit(nil)

                Spacer()

                Text("\(Int(self.value / 100 * 100))%")
                    .font(.system(size: 14))
                    .foregroundColor(Color("NewsCardItemTextColor"))
                    .padding(0)
            }.padding(10)
        }
    }
    
    private func progress(
        width: CGFloat
    ) -> CGFloat {
        let percentage = self.value / 100
        
        return width * CGFloat(percentage)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
