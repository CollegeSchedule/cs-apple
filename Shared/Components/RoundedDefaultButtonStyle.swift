import SwiftUI

struct RoundedDefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .foregroundColor(.white)
            .frame(maxWidth: 360, alignment: .center)
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
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .animation(.easeInOut)
    }
}

extension Button {
    func rounded() -> some View {
        return self.buttonStyle(RoundedDefaultButtonStyle())
    }
}
