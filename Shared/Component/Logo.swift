import SwiftUI

struct Logo: View {
    @State
    var isCompact: Bool = true
    
    private let gradient: Gradient = .init(
        colors: [
            Color.init(
                red: 35 / 255,
                green: 35 / 255,
                blue: 35 / 255
			),
            Color.init(
                red: 69 / 255,
                green: 69 / 255,
                blue: 69 / 255
			)
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
                Text("Электронное")
                    .font(
						.system(
							size: self.isCompact ? 16 : 30,
							weight: .medium,
							design: .rounded
						)
					)
                Text("Расписание")
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
