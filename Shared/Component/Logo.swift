import SwiftUI

struct Logo: View {
    @State
    var isCompact: Bool = true
    
    private let gradient: Gradient = .init(
        colors: [
            Color.logoGradientStart,
            Color.logoGradientEnd
        ]
	)
    
    var body: some View {
        HStack {
            ZStack {
                LinearGradient(
					gradient: self.gradient,
					startPoint: .top,
					endPoint: .bottom
				)
				.frame(
					minWidth: 0,
					maxWidth: self.isCompact ? 40 : 80,
					minHeight: 0,
					maxHeight: self.isCompact ? 40 : 80
				)
				.cornerRadius(12)
				
                Image(systemName: "books.vertical.fill")
					.font(.system(size: self.isCompact ? 20 : 40))
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading) {
                Text(LocalizedStringKey("authentication.logo.college"))
                    .font(
						.system(
							size: self.isCompact ? 16 : 30,
							weight: .medium,
							design: .rounded
						)
					)
                Text(LocalizedStringKey("authentication.logo.shedule"))
                    .font(
						.system(
							size: self.isCompact ? 16 : 30,
							weight: .medium,
							design: .rounded
						)
					)
            }
        }
    }
}
