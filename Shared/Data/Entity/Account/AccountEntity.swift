import Foundation

struct AccountEntity: Codable, Hashable {
    let id: Int
	
    let token: String?
    let mail: String?
	
	let avatar: String?
	
    let firstName: String
    let secondName: String
    let thirdName: String
	
    let createdAt: Int?
}

extension AccountEntity {
    var print: String {
        "\(self.secondName) \(self.firstName.prefix(1)). \(self.thirdName.prefix(1))."
    }
}
