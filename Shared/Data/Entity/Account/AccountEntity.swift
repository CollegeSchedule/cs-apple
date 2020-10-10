import Foundation

struct AccountEntity: Codable {
    let id: Int
    let token: String
    let mail: String?
    let firstName: String
    let secondName: String
    let thirdName: String
    let createdAt: Int
}
