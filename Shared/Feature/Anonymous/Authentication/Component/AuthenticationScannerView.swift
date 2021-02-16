import SwiftUI
import CodeScanner

struct AuthenticationScannerView: View {
    @ObservedObject
    var model: AuthenticationView.ViewModel
	
    var body: some View {
        NavigationView {
            ZStack {
                CodeScannerView(
                    codeTypes: [.qr],
                    completion: { result in
                        if case let .success(code) = result {
                            self.model.accountCode = code
                            self.model.sheetItem = nil
                        }
                    }
                )
                
                VStack {
                    Spacer()
                    
                    Button(action: self.openKeyboard) {
                        Text("anonymous.authentication.camera.open_keyboard")
                    }.buttonStyle(RoundedDefaultButtonStyle())
                }.padding()
            }
            .navigationTitle("anonymous.authentication.camera.title")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: self.close) {
                Image(systemName: "xmark")
            })
        }
    }
    
    private func openKeyboard() {
        self.model.sheetItem = .keyboard
    }
    
    private func close() {
        self.model.sheetItem = nil
    }
}
