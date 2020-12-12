import SwiftUI

struct APIResultView<T: Hashable, Content: View>: View {
    @Binding
    var status: APIResult<T>
    
    let content: (_ item: T) -> Content
    
    init(
        status: Binding<APIResult<T>>,
        @ViewBuilder content: @escaping (_ item: T) -> Content
    ) {
        self._status = status
        self.content = content
    }
    
//    init(
//        first: Binding<APIResult<T>>,
//        second: Binding<APIResult<T>>,
//        @ViewBuilder content: @escaping (_ item: T) -> Content
//    ) {
//         
//    }
    
    var body: some View {
        VStack{
            if case .error = status {
                Text("Error")
            } else if case let .success(item) = status {
                self.content(item)
            } else if case .empty = status {
                Text("Empty")
            } else if case .loading = status {
                Text("loading")
            }
        }
    }
}
