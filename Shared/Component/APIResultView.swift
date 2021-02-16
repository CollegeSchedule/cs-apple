import SwiftUI

struct APIResultView<T: Hashable, Empty: View, Content: View>: View {
    @Binding var result: APIResult<T>
    
    let empty: () -> Empty
    let content: (_ item: T) -> Content
    
    init(
        result: Binding<APIResult<T>>,
        @ViewBuilder empty: @escaping () -> Empty,
        @ViewBuilder content: @escaping (_ item: T) -> Content
    ) {
        self._result = result
        self.empty = empty
        self.content = content
    }
    
    var body: some View {
        VStack {
            if case let .success(content) = self.result {
                self.content(content)
            } else if case .empty = self.result {
                self.empty()
            } else if case .loading = self.result {
                ProgressView(NSLocalizedString("base.loading", comment: "Loading"))
            } else {
                Text(NSLocalizedString("base.error", comment: "Error"))
            }
        }
    }
}
