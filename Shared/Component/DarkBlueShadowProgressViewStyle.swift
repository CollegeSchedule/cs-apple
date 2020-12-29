import Foundation
import SwiftUI

struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(
                color: Color.progressDarkBlueShadowColor,
                radius: 4.0, x: 1.0, y: 2.0
            )
    }
}
