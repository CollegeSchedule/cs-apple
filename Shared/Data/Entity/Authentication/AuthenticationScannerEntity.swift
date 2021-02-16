import Foundation

struct AuthenticationScannerEntity: Codable {
    let id: Int
    let firstName: String
    let secondName: String
    let thirdName: String
	let avatar: String?
    let active: Bool
}
extension AuthenticationScannerEntity {
    var print: String {
        "\(self.secondName) \(self.firstName.prefix(1)). \(self.thirdName.prefix(1))."
    }
}
