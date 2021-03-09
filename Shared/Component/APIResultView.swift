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
                ErrorView(
                    animation: "error",
                    title: "Ошибка",
                    description: "Наши сервера игнорируют нас :("
                )
            }
        }
    }
}

struct APIResultView2<T: Hashable, D: Hashable, Empty: View, Content: View>: View {
    @Binding var first: APIResult<T>
    @Binding var second: APIResult<D>
    
    let empty: () -> Empty
    let content: (_ item: T, _ item: D) -> Content
    
    init(
        first: Binding<APIResult<T>>,
        second: Binding<APIResult<D>>,
        @ViewBuilder empty: @escaping () -> Empty,
        @ViewBuilder content: @escaping (_ item: T, _ item: D) -> Content
    ) {
        self._first = first
        self._second = second
        self.empty = empty
        self.content = content
    }
    
    var body: some View {
        self.result
    }
    
    private var result: some View {
        guard case let .success(first) = self.first, case let .success(second) = self.second else {
            if self.first == .loading || self.second == .loading {
                return ProgressView(NSLocalizedString("base.loading", comment: "Loading")).eraseToAnyView()
            }
            
            if self.first == .error(.init()) || self.second == .error(.init()) {
                return ErrorView(
                    animation: "error",
                    title: "Ошибка",
                    description: "Наши сервера игнорируют нас :("
                ).eraseToAnyView()
            }
            
            return self.empty().eraseToAnyView()
        }
        
        return self.content(first, second).eraseToAnyView()
    }
}
