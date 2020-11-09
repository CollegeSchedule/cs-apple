import Foundation

struct AuthenticationScannerEntity: Codable {
    let id: Int
    let firstName: String
    let secondName: String
    let thirdName: String
	let avatar: String?
    let active: Bool
    
}
