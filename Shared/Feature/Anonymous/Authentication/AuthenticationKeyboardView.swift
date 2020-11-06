import SwiftUI

struct AuthenticationKeyboardView: View {
    
    @Binding
    var isActive: AuthenticationScanerItem?
    
    @State
    private var text: String = ""
    
    var body: some View {
        ZStack{
            Color
                .backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Form {
                    TextField("Text", text: self.$text)
                }
                
                Spacer()
                
                Button(action: {
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
