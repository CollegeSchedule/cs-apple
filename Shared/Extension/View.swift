import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
    @ViewBuilder func applyIf<T: View>(
        _ condition: @autoclosure () -> Bool,
        apply: (Self) -> T,
        else: ((Self) -> T)? = nil
    ) -> some View {
        if condition() {
            apply(self)
        } else if `else` != nil {
            `else`?(self)
        } else {
            self
        }
    }
    
    func redactedIf(
        _ condition: @autoclosure () -> Bool
    ) -> some View {
        self.redacted(reason: condition() ? .placeholder : .init())
    }
    
}
