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
				TextField(LocalizedStringKey("authentication.keyboard.placeholder"), text: self.$text)
					.padding()
					.background(
						RoundedRectangle(cornerRadius: 8)
							.foregroundColor(
                                Color.formTextFieldBackgroudColor
                            )
					)
					.padding()
                
                Spacer()
				
				Button(action:{
					self.isActive = nil
				}){
					Text(LocalizedStringKey("authentication.keyboard.dissmiss"))
                }.onDisappear{
                    self.isActive = nil
                }
                
                Button(action: {
                        self.model.accountCode = self.text
                        self.isActive = nil
                }) {
                    ZStack {
                        Text(LocalizedStringKey("authentication.keyboard.get_started"))
                        
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
                        Text(LocalizedStringKey("authentication.keyboard.can_scan"))
                            .foregroundColor(.gray)
                        
                        Text(LocalizedStringKey("authentication.keyboard.go_scan"))
                            .foregroundColor(.accentColor)
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 10)
            }.padding()
        }
    }
}
