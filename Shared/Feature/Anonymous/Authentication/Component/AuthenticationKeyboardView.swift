import SwiftUI

struct AuthenticationKeyboardView: View {
    @ObservedObject
    var model: AuthenticationView.ViewModel
	
	@State
	private var text: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField(LocalizedStringKey("anonymous.authentication.field.code"), text: self.$text)
                }
                
                Spacer()
                
                Button(action: self.code) {
                    Text(LocalizedStringKey("anonymous.authentication.keyboard.verify"))
                }
                .rounded()
                .padding(20)
                .disabled(self.text.count != 36)
            }
            .navigationTitle("anonymous.authentication.keyboard.title")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: self.close) {
                Image(systemName: "xmark")
            })
        }
    }
    
    private func code() {
        self.model.accountCode = self.text
        self.close()
    }
    
    private func close() {
        self.model.sheetItem = nil
    }
}
