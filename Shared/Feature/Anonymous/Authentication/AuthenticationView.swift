import SwiftUI

struct AuthenticationView: View {
    @ObservedObject
    var model: AuthenticationView.ViewModel = .init()
    
    var body: some View {
        ZStack {
            Color
                .backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("CollegeSchedule")
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                
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
                    Text("Get Started")
                }.rounded().padding(.horizontal, 20).disabled(!self.model.isValid)
                
                Button(action: {
                    self.model.me()
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
                .sheet(isPresented: .constant(true)) {
                    Text("Register")
                }
            }
        }
    }
}
