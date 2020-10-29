import SwiftUI


struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color(red: 0, green: 0, blue: 0.6),
                    radius: 4.0, x: 1.0, y: 2.0)
    }
}

struct AuthenticationView: View {
    @EnvironmentObject
    var agent: Agent
    
    @ObservedObject
    private var model: AuthenticationView.ViewModel = .init()
    
    var body: some View {
        ZStack {
            Color
                .backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Logo()
                
                VStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(
                            minWidth: 0,
                            maxWidth: 113,
                            minHeight: 0,
                            maxHeight: 113
                        )
                }
                
                Form {
                    TextField("Email", text: self.$model.mail)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: self.$model.password)
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Button(action: self.model.login) {
                    ZStack {
                        Text("Get Started")
                        
                        if case APIResult.loading = self.model.status {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .rounded()
                .padding(.horizontal, 20)
                .disabled(!self.model.isValid)
                
                Button(action: {
//                    self.model.me()
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
}

