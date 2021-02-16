import SwiftUI

enum AccountStatusResult: Equatable {
    case success(AuthenticationScannerEntity)
    case empty
    case notFound
    
    static func == (
        lhs: AccountStatusResult,
        rhs: AccountStatusResult
    ) -> Bool {
        switch (lhs, rhs) {
            case (.success, .success):
                return true
            case (.notFound, .notFound):
                return true
            case (.empty, .empty):
                return true
            default:
                return false
        }
    }
}
