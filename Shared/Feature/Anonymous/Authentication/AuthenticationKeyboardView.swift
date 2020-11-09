import SwiftUI

struct AuthenticationKeyboardView: View {
    
    @Binding
    var isActive: AuthenticationScanerItem?
    
	@ObservedObject
	var model: AuthenticationView.ViewModel
	
	@State
	private var text: String = ""
    
    var body: some View {
        ZStack{
            Color
                .backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack{
				TextField("Text", text: self.$text)
					.padding()
					.background(
						RoundedRectangle(cornerRadius: 8)
							.foregroundColor(Color("FormTextFieldBackgroundColor"))
					)
					.padding()
                
                Spacer()
                
                Button(action: {
					self.model.statusScanner(token: self.text)
                    self.isActive = nil
                }){
                    Text("Get")
                }
                
                Button(action: {
                    self.isActive = .camera
                }) {
                    Text("Go camera")
                }
            }.padding()
        }
    }
}
