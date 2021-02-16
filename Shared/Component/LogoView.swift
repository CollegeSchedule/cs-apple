import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack {
            ZStack {
                LinearGradient(gradient: LogoView.gradient,	startPoint: .top, endPoint: .bottom)
                    .frame(minWidth: 0, maxWidth: 40, minHeight: 0, maxHeight: 40)
                    .cornerRadius(12)
				
                Image(systemName: "books.vertical.fill")
					.font(.system(size: 20))
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                Text(LocalizedStringKey("authentication.logo.college"))
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                Text(LocalizedStringKey("authentication.logo.shedule"))
                    .font(.system(size: 16, weight: .medium, design: .rounded))
            }
        }
    }
    
    private static let gradient: Gradient = .init(
        colors: [
            Color.logoGradientStart,
            Color.logoGradientEnd
        ]
    )
}
