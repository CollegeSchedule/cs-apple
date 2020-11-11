import SwiftUI
import CodeScanner

struct AuthenticationScannerView: View {
    @ObservedObject
    var model: AuthenticationView.ViewModel
        
    @Binding
	var isActive: AuthenticationScanerItem?
	
    var body: some View {
        ZStack{
            CodeScannerView(
                codeTypes: [.qr],
                completion: { result in
                    if case let .success(code) = result {
                        self.model.accountCode = code
                        
                        self.isActive = nil
                    }
                }
            )
            VStack {
                VStack(spacing: 20) {
                    Text("Scan your account's QR-Code")
                        .font(.largeTitle)
                    
                    Text("If you doesn't have a QR-code, you should ask your master for them")
                }
                .padding()
                .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {
                    self.isActive = .keyboard
                }) {
                    HStack {
                        Text("Can't scan a QR-code?")
                            .foregroundColor(.gray)
                        
                        Text("Go to keybaord")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 10)
            }.padding()
        }
    }
}
