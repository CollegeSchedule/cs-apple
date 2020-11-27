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
				VStack(spacing: 12) {
					HStack(alignment: .top) {
						Button(action: {
							self.model.sheetItem = nil
						}) {
							Image(systemName: "multiply")
								.font(.system(size: 32))
						}.padding(.top, 12)
						
                        // MARK: - Move to localization
						Text("Scan your account's QR-Code")
							.font(.largeTitle)
					}
					
                    // MARK: - Move to localization
					Text("If you doesn't have a QR-code, you should ask your master for them")
				}
				.multilineTextAlignment(.center)
                .padding(.vertical)
                .padding(.top)
                
                
                Spacer()
                
//                Button(action: {
////                    self.isActive = .keyboard
//                }) {
//                    HStack {
//                        Text("Can't scan a QR-code?")
//                            .foregroundColor(.gray)
//
//                        Text("Go to keybaord")
//                            .foregroundColor(.accentColor)
//                    }
//                }
//                .padding([.horizontal, .bottom], 20)
//                .padding(.top, 10)
            }.padding()
        }
    }
}
