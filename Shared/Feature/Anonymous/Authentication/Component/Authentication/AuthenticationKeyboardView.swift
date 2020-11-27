import SwiftUI

struct AuthenticationKeyboardView: View {
    @ObservedObject
    var model: AuthenticationView.ViewModel
    
    @Binding
    var isActive: AuthenticationScanerItem?
	
	@State
	private var text: String = ""
    
    var body: some View {
        ZStack {
            Color
                .backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
				TextField("Text", text: self.$text)
					.padding()
					.background(
						RoundedRectangle(cornerRadius: 8)
							.foregroundColor(
                                // MARK: - Move to Color extension
                                Color("FormTextFieldBackgroundColor")
                            )
					)
					.padding()
                
                Spacer()
				
				Button(action:{
					self.isActive = nil
				}){
                    // MARK: - Move to localization
					Text("Dismiss")
				}
                
                Button(action: {
                        self.model.accountCode = self.text
                        self.isActive = nil
                }) {
                    ZStack {
                        // MARK: - Move to localization
                        Text("Get Started")
                        
                        if case APIResult.loading = self.model.status {
                            ProgressView()
                                .progressViewStyle(
                                    CircularProgressViewStyle(tint: .white)
                                )
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    alignment: .trailing
                                )
                        }
                    }
                }
                .rounded()
                .padding(.horizontal, 20)
                .disabled(self.text.count != 36)
                
                Button(action: {
                    self.isActive = .camera
                }) {
                    HStack {
                        // MARK: - Move to localization
                        Text("Can scan a QR-code?")
                            .foregroundColor(.gray)
                        
                        // MARK: - Move to localization
                        Text("Go to scanner")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 10)
            }.padding()
        }
    }
}
