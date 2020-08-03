import SwiftUI

struct NewsView: View {
    private var columns: [GridItem] = [.init(.adaptive(minimum: 350), spacing: 26)]
    
    struct CardItems {
        var id: Int
        var items: [CardPollItem]
    }
    
    private var items: [CardItems] = [
        CardItems(
            id: 1,
            items: [
                CardPollItem(
                    id: 1,
                    title: "SwiftUI is a modern way to declare user interfaces for any Apple platform.",
                    value: 50
                ),
                CardPollItem(
                    id: 2,
                    title: "SwiftUI is a modern way to declare user interfaces for any Apple platform.",
                    value: 50
                ),
                CardPollItem(
                    id: 3,
                    title: "SwiftUI is a modern way to declare user interfaces for any Apple platform.",
                    value: 50
                )
            ]
        )
    ]
        
    var body: some View {
        ScrollView {
            LazyVGrid(columns: self.columns, spacing: 26) {
                ForEach(self.items, id: \.id) { item in
                    NavigationLink(destination: NewsPreview()) {
                        CardView(items: item.items)
                    }
                }
            }.padding(20)
        }.navigationTitle(Text("Новости"))
    }
}

struct NewsPreview: View {
    var body: some View {
        ZStack {
            ScrollView {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. At risus viverra adipiscing at in tellus integer feugiat. Non arcu risus quis varius quam quisque id. Justo eget magna fermentum iaculis. Nec feugiat nisl pretium fusce id velit ut. Sollicitudin aliquam ultrices sagittis orci a scelerisque purus semper eget. Mattis vulputate enim nulla aliquet porttitor lacus. Lectus magna fringilla urna porttitor rhoncus. Tempor nec feugiat nisl pretium. Odio morbi quis commodo odio aenean sed. Tellus cras adipiscing enim eu turpis. Felis bibendum ut tristique et. Massa sapien faucibus et molestie ac. Velit dignissim sodales ut eu sem integer vitae. Id cursus metus aliquam eleifend. Faucibus pulvinar elementum integer enim neque volutpat ac. Neque egestas congue quisque egestas diam in arcu cursus. Aliquet eget sit amet tellus cras. Natoque penatibus et magnis dis parturient. Urna duis convallis convallis tellus id interdum. Malesuada fames ac turpis egestas. Urna et pharetra pharetra massa massa ultricies mi. Fames ac turpis egestas maecenas pharetra convallis posuere morbi. Arcu bibendum at varius vel pharetra. Sit amet nisl suscipit adipiscing. Elementum facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Ultrices gravida dictum fusce ut placerat. Auctor urna nunc id cursus metus aliquam eleifend mi in. Ullamcorper velit sed ullamcorper morbi tincidunt ornare. Rhoncus aenean vel elit scelerisque. Integer eget aliquet nibh praesent. Neque laoreet suspendisse interdum consectetur libero id. Risus at ultrices mi tempus imperdiet nulla malesuada pellentesque. Sit amet venenatis urna cursus. Pellentesque massa placerat duis ultricies lacus sed turpis tincidunt id. Donec et odio pellentesque diam volutpat commodo sed egestas. Eu sem integer vitae justo eget magna fermentum iaculis eu. Proin sed libero enim sed. Nunc scelerisque viverra mauris in aliquam sem fringilla ut. Ultricies lacus sed turpis tincidunt id aliquet risus. Quisque sagittis purus sit amet volutpat consequat. Sed viverra tellus in hac habitasse platea. Sed viverra tellus in hac habitasse platea. Cras pulvinar mattis nunc sed blandit. Natoque penatibus et magnis dis. Faucibus a pellentesque sit amet. Integer feugiat scelerisque varius morbi. Massa enim nec dui nunc mattis enim. Iaculis eu non diam phasellus. Euismod quis viverra nibh cras pulvinar mattis nunc sed. Tristique senectus et netus et malesuada fames. Vitae tortor condimentum lacinia quis. Mi ipsum faucibus vitae aliquet nec ullamcorper. Aliquet nibh praesent tristique magna sit amet purus gravida. Mattis vulputate enim nulla aliquet. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Bibendum neque egestas congue quisque. Tellus in hac habitasse platea dictumst vestibulum rhoncus est pellentesque. In eu mi bibendum neque. Bibendum ut tristique et egestas quis ipsum suspendisse. Turpis massa sed elementum tempus egestas sed. Convallis a cras semper auctor neque vitae. Fermentum posuere urna nec tincidunt. Integer feugiat scelerisque varius morbi. Donec ac odio tempor orci dapibus ultrices in iaculis. Urna nunc id cursus metus aliquam eleifend mi in nulla. Lobortis elementum nibh tellus molestie nunc non blandit. Enim diam vulputate ut pharetra sit amet. In fermentum et sollicitudin ac orci phasellus egestas tellus. Malesuada fames ac turpis egestas integer eget aliquet nibh praesent. Vitae suscipit tellus mauris a diam maecenas sed enim. Placerat in egestas erat imperdiet sed euismod nisi porta. Commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend.").padding().padding(.bottom, 72)
                
            }
            VStack {
                Spacer()
                
                HStack(alignment: .center) {
                    Rectangle()
                        .frame(width: 40, height: 40)
                        .background(Color.black)
                        .cornerRadius(8)
                        .padding(8)
                    
                    Text("Я не понял, кто тут мать вашу принцесса?")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(0)
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                    Spacer()
                }.background(
                    ZStack {
                        VisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialLight))
                            .edgesIgnoringSafeArea(.all)
                            .cornerRadius(8)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .opacity(0)
                    }
                ).padding(.horizontal, 20).padding(.bottom, 20)
            }
        }
    }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("This is a modal view")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct NewsPreviewProvider: PreviewProvider {
    static var previews: some View {
        NewsPreview()
    }
}

struct CardView: View {
    @State
    var items: [CardPollItem] = []
    
    var body: some View {
        CardViewContent(items: self.items)
            .padding(20)
            .background(
                Rectangle()
                    .foregroundColor(Color("NewsCardBackgroundColor"))
                    .frame(minHeight: 350)
                    .cornerRadius(12)
                    .shadow(
                        color: Color(
                            .sRGBLinear,
                            white: 0,
                            opacity: 0.15
                        ),
                        radius: 12,
                        y: 8
                    )
            )
    }
}

struct CardPollItem: Hashable {
    var id: Int
    var title: String
    var value: Int
}

struct CardViewContent: View {
    @State
    var items: [CardPollItem]
    
    @State
    var value: Double = 100.0
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Голосование")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("NewsCardTitleColor"))
                    Spacer()
                    
                    Text("Jun 4")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("NewsCardTitleColor"))
                }
                
                HStack {
                    Text("Я не понял, кто тут мать вашу принцесса?")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.top, 20)
            }
                    
            VStack {
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sed velit dignissim sodales ut eu sem integer vitae justo. Nulla posuere sollicitudin aliquam ultrices sagittis orci a. Interdum velit euismod in pellentesque. Interdum consectetur libero id faucibus nisl tincidunt eget."
                ).padding(.vertical, 40).foregroundColor(Color("NewsCardBottomTitleColor"))
            }
            
//            ScrollView {
//                ForEach(0..<self.items.count, id: \.self) { id in
//                    ProgressBar(text: self.items[id].title, value: .constant(Double(self.items[id].value)))
//                        .onTapGesture {
//                            self.items[id].value = 70
//                        }
//                }
//            }.padding(.top, 40)

            
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
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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
