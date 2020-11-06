import SwiftUI

enum AuthenticationItem: String {
    case empty = "empty"
    case success = "success"
    case notFound = "notFound"
    case activated = "activated"
}

enum AuthenticationScanerItem: CaseIterable, Identifiable {
    var id: Int {
        hashValue
    }
    
    case camera
    case keyboard
}
