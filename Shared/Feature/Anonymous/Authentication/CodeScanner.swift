import SwiftUI
import CodeScanner

struct CodeScanner: View {
    @ObservedObject
    var model: AuthenticationView.ViewModel
    
    @Binding
    var item: AuthenticationItem
    
    @Binding
	var isActive: AuthenticationScanerItem?
	
    var body: some View {
        ZStack{
            CodeScannerView(
                codeTypes: [.qr],
                completion: { result in
                    if case let .success(code) = result {
                        self.model.statusScanner(token: code)
                        self.isActive = nil
                    }
                }
            )
            VStack{
                Text("fdalkfdaslkdf")
                
                Spacer()
                
                Button(action: {
                    self.isActive = .keyboard
                }) {
                    Text("Go keyboard")
                }
            }.padding()
        }
    }
}
