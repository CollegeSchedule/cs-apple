import SwiftUI

struct AuthenticationView: View {
    @ObservedObject
    private var model: AuthenticationView.ViewModel = .init()
    
    var body: some View {
        ZStack {
            VStack {
                Logo()
                    .padding(20)
                    .sheet(item: self.$model.sheetItem) { item in
                        switch item {
                            case .camera:
                                AuthenticationScannerView(
                                    model: self.model,
                                    isActive: self.$model.sheetItem
                                ).ignoresSafeArea()
                            case .keyboard:
                                AuthenticationKeyboardView(
                                    model: self.model,
                                    isActive: self.$model.sheetItem
                                ).ignoresSafeArea()
                        }
                    }
                
                Spacer()
                AuthenticationItemView(item: self.$model.account)
                Spacer()
                
                self.formView()
                
                Button(action: self.model.login) {
                    ZStack {
                        Text(LocalizedStringKey(self.actionText()))
                        
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
                        Text(LocalizedStringKey("authentication.no_account"))
                            .foregroundColor(.gray)
                        Text(LocalizedStringKey("authentication.sign_up"))
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
            if case let .success(content) = self.model.account, content.active {
                EmptyView()
            } else {
                TextField(LocalizedStringKey("authentication.field_email"), text: self.$model.mail)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
                Divider().padding(.leading)
            }
            
            SecureField(LocalizedStringKey("authentication.field_password"), text: self.$model.password)
                .textContentType(.password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal)
                .padding(.vertical, 10)
            
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.formTextFieldBackgroudColor)
        )
        .padding([.horizontal, .bottom], 20)
        .eraseToAnyView()
    }
    
    private func actionText() -> String {
        if case let .success(content) = self.model.account, !content.active {
            return "authentication.sign_up"
        }
        
        return "authentication.sign_in"
    }
}

