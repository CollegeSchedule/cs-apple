import SwiftUI

struct APIResultView<T: Hashable, Content: View>: View {
    @Binding
    var status: APIResult<T>
    
    let title: String
    let content: (_ item: T) -> Content
    
    init(
        status: Binding<APIResult<T>>,
        title: String,
        @ViewBuilder content: @escaping (_ item: T) -> Content
    ) {
        self._status = status
        self.title = title
        self.content = content
    }
    
    var body: some View {
        if case .error = status {
            Text(
                LocalizedStringKey(
                    "authenticated.component.api_result_view.error"
                )
            )
        } else if case let .success(item) = status {
            self.content(item)
        } else if case .empty = status {
            VStack{
                TitleItemView(title: self.title)
                Text(
                    LocalizedStringKey(
                        "authenticated.component.api_result_view.empty"
                    )
                )
                .padding(.top)
            }
        } else if case .loading = status {
            EmptyView()
        }
    }
}
