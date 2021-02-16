import SwiftUI
import SPAlert

struct ProfileEmailView: View {
    @EnvironmentObject
    private var state: CollegeSchedule.ViewModel
    
    @ObservedObject
    private var model: ProfileEmailView.ViewModel = .init()
    
    var body: some View {
        VStack {
            List {
                TextField("authenticated.home.profile.credentials.mail.field.new", text: self.$model.new)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextField("authenticated.home.profile.credentials.mail.field.confirm", text: self.$model.confirm)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }.listStyle(InsetGroupedListStyle())
            
            Button(action: self.model.execute) {
                Text("authenticated.home.profile.credentials.mail.action")
            }.rounded().padding()
        }
        .modifier(BackgroundModifier(color: .formBackgroundColor))
        .navigationTitle(Text("authenticated.home.profile.credentials.mail.title"))
        .onReceive(self.model.$status) { result in
            if case .success = result {
                self.model.new = ""
                self.model.confirm = ""
                self.model.status = .empty
                
                self.state.fetch()
                
                SPAlert.present(
                    title: NSLocalizedString("authenticated.home.profile.credentials.mail.changed", comment: ""),
                    preset: .done
                )
            }
        }
    }
}
