import SwiftUI
import SPAlert

struct SignInView: View {
    @ObservedObject
    private var model: AuthenticationView.ViewModel = .init()
    
    @State
    var isCameraShowed: Bool = false
    
    @State
    var isKeyboardShowed: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            AuthenticationItemView(item: self.$model.account)
            
            Spacer()
            
            self.formView
            
            Button(action: self.model.login) {
                ZStack {
                    Text(LocalizedStringKey(self.actionText))
                    
                    if case APIResult.loading = self.model.status {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }.rounded().disabled(!self.model.isValid)
            
            Button(action: self.showCamera) {
                HStack {
                    Text(LocalizedStringKey("anonymous.authentication.no_account.title")).foregroundColor(.gray)
                    Text(LocalizedStringKey("anonymous.authentication.no_account.action"))
                        .foregroundColor(.invertedDefaultColor)
                }
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(self.actionText)
        .sheet(item: self.$model.sheetItem) { item in
            switch item {
                case .camera: AuthenticationScannerView(model: self.model)
                case .keyboard: AuthenticationKeyboardView(model: self.model)
            }
        }
        .onReceive(self.model.$account, perform: { result in
            if case let .success(content) = result {
                if (content.active) {
                    SPAlert.present(title: "anonymous.authentication.account.already.active", preset: .error)
                }
            }
        })
    }
    
    private func showCamera() {
        self.model.sheetItem = .camera
    }
    
    private var formView: AnyView {
        return VStack(spacing: 0) {
            TextField(LocalizedStringKey("anonymous.authentication.field.email"), text: self.$model.mail)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal)
                .padding(.vertical, 10)
            
            Divider().padding(.leading)
            
            SecureField(LocalizedStringKey("anonymous.authentication.field.password"), text: self.$model.password)
                .textContentType(.password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal)
                .padding(.vertical, 10)
            
            if case let .success(content) = self.model.account, !content.active {
                Divider().padding(.leading)
                
                SecureField(
                    LocalizedStringKey("anonymous.authentication.field.password.confirm"),
                    text: self.$model.passwordConfirm
                )
                .textContentType(.password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
        }
        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color.formTextFieldBackgroudColor))
        .padding(.bottom, 20)
        .eraseToAnyView()
    }
    
    private var actionText: String {
        if case let .success(content) = self.model.account, !content.active {
            return NSLocalizedString("anonymous.authentication.sign_up", comment: "")
        }
        
        return NSLocalizedString("anonymous.authentication.sign_in", comment: "")
    }
}
