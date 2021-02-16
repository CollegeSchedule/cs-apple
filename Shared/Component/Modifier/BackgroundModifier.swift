import SwiftUI

struct BackgroundModifier: ViewModifier {
    private let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        ZStack {
            self.color.ignoresSafeArea()
            
            content
        }
    }
}
