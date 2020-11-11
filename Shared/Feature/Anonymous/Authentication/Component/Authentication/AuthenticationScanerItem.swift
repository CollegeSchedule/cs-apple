enum AuthenticationScanerItem: CaseIterable, Identifiable, Hashable {
    var id: Int {
        self.hashValue
    }
    
    case camera
//    case keyboard
}
