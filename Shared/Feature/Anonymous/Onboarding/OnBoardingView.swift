import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject
    private var state: CollegeSchedule.ViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("anonymous.on_boarding.title.first", comment: ""))
                        .modifier(OnBoardingTextModifier())
                    
                    HStack {
                        Text(NSLocalizedString("anonymous.on_boarding.title.second", comment: ""))
                            .modifier(OnBoardingTextModifier())
                        
                        Text("CollegeSchedule").modifier(OnBoardingTextModifier()).foregroundColor(.blue)
                    }
                }
                
                Spacer()
            }.padding(.bottom, 40)
            
            VStack(spacing: 14) {
                OnBoardingItemView(
                    icon: "newspaper",
                    title: NSLocalizedString("anonymous.on_boarding.item.first.title", comment: ""),
                    description: NSLocalizedString("anonymous.on_boarding.item.first.description", comment: "")
                )
                
                OnBoardingItemView(
                    icon: "calendar",
                    title: NSLocalizedString("anonymous.on_boarding.item.second.title", comment: ""),
                    description: NSLocalizedString("anonymous.on_boarding.item.second.description", comment: "")
                )
                
                OnBoardingItemView(
                    icon: "message",
                    title: NSLocalizedString("anonymous.on_boarding.item.third.title", comment: ""),
                    description: NSLocalizedString("anonymous.on_boarding.item.third.description", comment: "")
                )
                
                OnBoardingItemView(
                    icon: "folder.fill",
                    title: NSLocalizedString("anonymous.on_boarding.item.fourth.title", comment: ""),
                    description: NSLocalizedString("anonymous.on_boarding.item.fourth.description", comment: "")
                )
            }
            
            Spacer()
        
            NavigationLink(destination: SignInView()) {
                Text("Continue")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .foregroundColor(Color.defaultColor)
            }
            .frame(maxWidth: 360, maxHeight: 44, alignment: .center)
            .background(Color.invertedDefaultColor)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }.padding(UIDevice.isSmall ? 20 : 40).navigationBarHidden(true).onDisappear {
            // a little bit hacky way to not conflict with navigation animation
            UserDefaults.standard.setValue(try! JSONEncoder().encode(true), forKey: "on_boarding_complete")
            UserDefaults.standard.synchronize()
        }
    }
}

struct OnBoardingTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .bold, design: .default))
            .lineLimit(34)
    }
}
