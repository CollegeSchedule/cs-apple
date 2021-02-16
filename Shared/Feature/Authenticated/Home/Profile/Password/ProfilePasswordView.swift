import SwiftUI
import SPAlert

struct ProfilePasswordView: View {
    @EnvironmentObject
    private var state: CollegeSchedule.ViewModel
    
    @ObservedObject
    private var model: ProfilePasswordView.ViewModel = .init()
    
    var body: some View {
        VStack {
            List {
                SecureField("authenticated.home.profile.credentials.password.field.old", text: self.$model.old)
                SecureField("authenticated.home.profile.credentials.password.field.new", text: self.$model.new)
                SecureField("authenticated.home.profile.credentials.password.field.confirm", text: self.$model.confirm)
            }.listStyle(InsetGroupedListStyle())
            
            Button(action: self.model.execute) {
                Text("authenticated.home.profile.credentials.password.action")
            }.rounded().padding()
        }
        .modifier(BackgroundModifier(color: .formBackgroundColor))
        .navigationTitle(Text("authenticated.home.profile.credentials.password.title"))
        .onReceive(self.model.$status) { result in
            if case .success = result {
                self.model.old = ""
                self.model.new = ""
                self.model.confirm = ""
                self.model.status = .empty
                
                self.state.fetch()
                
                SPAlert.present(
                    title: NSLocalizedString("authenticated.home.profile.credentials.password.changed", comment: ""),
                    preset: .done
                )
            }
        }
    }
}
