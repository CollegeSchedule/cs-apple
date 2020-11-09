import SwiftUI


struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color(red: 0, green: 0, blue: 0.6),
                    radius: 4.0, x: 1.0, y: 2.0)
    }
}

struct AuthenticationView: View {
	
    @ObservedObject
    private var model: AuthenticationView.ViewModel = .init()
    
    var body: some View {
        ZStack {
            Color
                .backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
				
                Logo()
					.padding(20)
				
				Spacer()
				
				if self.model.item != AuthenticationItem.empty {
					VStack{
						Spacer()
						
//						AuthenticationItemView(item: self.model.item, text: self.model.nameAccount)
						
						Spacer()
					}
                }
				
				Spacer()
				
				VStack(spacing: 0) {
					TextField("Email", text: self.$model.mail, onCommit: {
						print("Ok")
					})
					.textContentType(.emailAddress)
					.keyboardType(.emailAddress)
					.autocapitalization(.none)
					.disableAutocorrection(true)
					.padding(.horizontal)
					.padding(.vertical, 10)
					.sheet(item: self.$model.sheetItem) { item in
							switch item {
							case .camera:
								CodeScanner(model: self.model, item: self.$model.item, isActive: self.$model.sheetItem)
							case .keyboard:
								AuthenticationKeyboardView(isActive: self.$model.sheetItem, model: self.model)
							}
						}
					
					Divider()
						.padding(.leading)
						
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
}

