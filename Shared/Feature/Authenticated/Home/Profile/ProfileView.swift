import SwiftUI
import SDWebImageSwiftUI
import Introspect

struct ProfileView: View {
    @Binding
    var account: APIResult<AccountMeEntity>
    
    @Binding
    var isPresented: Bool
    
    @State
    var ago: String = NSLocalizedString(
        "authenticated.home.profile.credentials.password.changed.never",
        comment: ""
    )
    
    @State
    private var isLogoutPresented: Bool = false
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        APILoadingView(result: self.$account, empty: { Text("Empty") }) { loading, result in
            NavigationView {
                List {
                    Section(header: Text("authenticated.home.profile.profile.title")) {
                        HStack {
                            self.avatar(item: result, size: 38)
                            
                            VStack {
                                RedactedView(state: loading) {
                                    Text(result!.account.full)
                                }
                            }
                        }.padding(.vertical, 4)
                    }
                    
                    Section(header: Text("authenticated.home.profile.basic.title")) {
                        HStack {
                            Text("authenticated.home.profile.basic.field.position")
                            Spacer()
                            RedactedView(state: loading) {
                                Text(NSLocalizedString(
                                    "authenticated.home.profile.basic.field.position.\(result!.account.label!.rawValue.lowercased())",
                                    comment: ""
                                )).foregroundColor(.gray)
                            }
                        }
                        
                        if result?.account.group != nil {
                            HStack {
                                Text("authenticated.home.profile.basic.field.group")
                                Spacer()
                                Text(result!.account.group!.print!).foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Section(header: Text("authenticated.home.profile.credentials.title")) {
                        NavigationLink(destination: ProfileEmailView()) {
                            HStack {
                                Text("authenticated.home.profile.credentials.field.email")
                                Spacer()
                                RedactedView(state: loading) {
                                    Text(result!.account.mail!).foregroundColor(.gray)
                                }
                            }
                        }.disabled(loading)
                        
                        NavigationLink(destination: ProfilePasswordView()) {
                            HStack {
                                Text("authenticated.home.profile.credentials.field.password")
                                Spacer()
                                RedactedView(state: loading) {
                                    Text(self.ago).foregroundColor(.gray)
                                }
                            }
                        }.disabled(loading)
                    }
                    
                    Section {
                        Button(action: {
                            self.isLogoutPresented = true
                        }) {
                            Label(LocalizedStringKey("authenticated.settings.log_out"), image: "globe")
                                .foregroundColor(.red)
                                .labelStyle(TitleOnlyLabelStyle())
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(NSLocalizedString("authenticated.home.profile.title", comment: ""))
                .navigationBarItems(trailing: Button(action: self.close) {
                    Text("base.done")
                })
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(self.timer) { _ in
                    self.calculateAge()
                }
            }
        }
        .actionSheet(isPresented: self.$isLogoutPresented, content: {
            ActionSheet(
                title: Text(LocalizedStringKey("authenticated.settings.log_out")),
                message: Text(LocalizedStringKey("authenticated.settings.message_log_out")),
                buttons: [
                    .destructive(
                        Text(LocalizedStringKey("authenticated.settings.log_out")),
                        action: {
                            self.isLogoutPresented = false
                            self.isPresented = false
                            AgentKey.defaultValue.isAuthenticated = false
                        }
                    ),
                    
                    .cancel()
                ]
            )
        })
    }
    
    private func close() {
        self.isPresented = false
    }
    
    private func avatar(item: AccountMeEntity?, size: CGFloat) -> some View {
        if item?.account.avatar == nil {
            return Image(systemName: "person.circle.fill")
                .resizable().frame(width: size, height: size, alignment: .center)
                .eraseToAnyView()
        }
        
        return WebImage(url: URL(string: item!.account.avatar!)!)
            .resizable()
            .placeholder {
                Image(systemName: "person.circle.fill")
                    .resizable().frame(width: size, height: size, alignment: .center)
                    .eraseToAnyView()
            }.frame(width: size, height: size, alignment: .center).clipShape(Circle()).eraseToAnyView()
    }
    
    private func calculateAge() {
        if case let .success(content) = self.account {
            if content.account.passwordChangedAt == nil {
                self.ago = NSLocalizedString(
                    "authenticated.home.profile.credentials.password.changed.never",
                    comment: ""
                )
                
                return
            }
            
            self.ago = NSLocalizedString(
                "authenticated.home.profile.credentials.password.changed.ago",
                comment: ""
            ) + Date.RELATIVE.localizedString(
                for: Date(timeIntervalSince1970: Double(content.account.passwordChangedAt!)),
                relativeTo: Date()
            )
        }
    }
}
