import SwiftUI

struct AuthenticationView: View {
    @ObservedObject
    private var model: AuthenticationView.ViewModel = .init()
    
    var body: some View {
        ZStack {
            Form {
                EmptyView()
                    .sheet(item: self.$model.sheetItem) { item in
                        switch item {
                            case .camera:
                                AuthenticationScannerView(
                                    model: self.model,
                                    isActive: self.$model.sheetItem
                                )
                            case .keyboard:
                                AuthenticationKeyboardView(
                                    model: self.model,
                                    isActive: self.$model.sheetItem
                                )
                        }
                    }
            }
            
            Color
                .backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Logo().padding(20)
				
				Spacer()
                AuthenticationItemView(item: self.$model.account)
				Spacer()
                
                self.formView()

                Button(action: self.model.login) {
                    ZStack {
                        Text(self.actionText())
                        
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
                .disabled(!self.model.isValid)
                
                Button(action: {
                    self.model.sheetItem = .camera
                }) {
                    HStack {
                        Text("Doesn't have an account?")
                            .foregroundColor(.gray)
                        
                        Text("Sign Up")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 10)
            }
        }
    }
    
    private func formView() -> AnyView {
        if case .notFound = self.model.account {
            return EmptyView().eraseToAnyView()
        }
        
        return VStack(spacing: 0) {
            if case .empty = self.model.account {
                TextField("Email", text: self.$model.mail)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
                Divider().padding(.leading)
            }
                
            SecureField("Password", text: self.$model.password)
                .textContentType(.password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal)
                .padding(.vertical, 10)
            
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color("FormTextFieldBackgroundColor"))
        )
        .padding([.horizontal, .bottom], 20)
        .eraseToAnyView()
    }
    
    private func actionText() -> String {
        if case .success = self.model.account {
            return "Зарегистрироваться"
        }
        
        return "Войти"
    }
}

