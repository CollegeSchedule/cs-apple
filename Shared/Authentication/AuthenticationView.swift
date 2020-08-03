import SwiftUI
import CodeScanner
import SPPermissions

struct AuthenticationView: View {
    @State
    private var isPresented = false
    
    var body: some View {
        VStack {
            Spacer()
            
//            VStack {
//                CodeScannerView(
//                    codeTypes: [.qr],
//                    simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
//                    completion: self.handleScan
//                )
//            }
            
            Spacer()
            
            ZStack {
                        Button(action: {
                            self.isPresented.toggle()
                        }) {
                            Text("Permissions").padding()
                        }
                        if (isPresented) {
                            PermissionsWrapperView(isShown: $isPresented)
                        }
                    }
            
            Button(action: {
                
            }) {
                Text("Continue")
            }
            .buttonStyle(RoundedDefaultButton())
            .padding(.horizontal, 40)
            .padding(.vertical, 20)
            
            HStack {
                Text("Already have account?")
                    .foregroundColor(.gray)
                
                Button(action: {}) {
                    Text("Sign in")
                }
            }.padding(.horizontal)
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       print(result)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}

struct PermissionsWrapperView: UIViewControllerRepresentable {
    @Binding var isShown: Bool

    func makeCoordinator() -> PermissionsWrapperView.Coordinator {
        return Coordinator(self, isShown: $isShown)
    }


    @State var isPresenting = false
    func makeUIViewController(context: Context) -> SPPermissionsListController {
        let permissionsController = SPPermissions.list([.camera].filter { !$0.isAuthorized })
        permissionsController.delegate = context.coordinator
        permissionsController.present(on: UIApplication.shared.windows.first?.rootViewController as! UIViewController)
        return permissionsController
    }

     func updateUIViewController(_ permissionController: SPPermissionsListController, context: Context) {
        if (self.isShown) {

        }
    }


    class Coordinator: NSObject, SPPermissionsDelegate {
        var parent: PermissionsWrapperView
        @Binding var isCoordinatorShown: Bool


        init(_ parent: PermissionsWrapperView, isShown: Binding<Bool>) {
            self.parent = parent
            _isCoordinatorShown = isShown

        }


        func didHide(permissions ids: [Int]) {
            print("------------ Hide controller!!!")
            isCoordinatorShown = false
        }

        func didAllow(permission: SPPermission) {
            print("Did allow: ", permission.name)
        }

    }
}
