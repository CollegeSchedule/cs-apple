import SwiftUI

struct RoundedDefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .semibold, design: .default))
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .foregroundColor(configuration.isPressed ? Color.defaultColor.opacity(0.5) : Color.defaultColor)
            .frame(maxWidth: 360, maxHeight: 44, alignment: .center)
            .listRowBackground(
                configuration.isPressed ? Color.invertedDefaultColor.opacity(0.5) : Color.invertedDefaultColor
            )
            .background(
                configuration.isPressed ? Color.invertedDefaultColor.opacity(0.5) : Color.invertedDefaultColor
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

extension Button {
    func rounded() -> some View {
        return self.buttonStyle(RoundedDefaultButtonStyle())
    }
}
