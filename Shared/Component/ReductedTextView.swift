import SwiftUI

struct RedactedView<Content: View>: View {
    private let state: Bool
    private let content: () -> Content
    
    init(state: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.state = state
        self.content = content
    }
    
    var body: some View {
        if self.state {
            Text("Some loading data").redacted(reason: .placeholder)
        } else {
            self.content()
        }
    }
}
