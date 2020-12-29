struct GroupEntity: Codable, Hashable {
    let id: Int
    let name: Int
    let print: String?
    let educationLevel: GroupEducationLevel?
    let course: Int?
    let startYear: Int?
    let commercial: Bool?
    let specialtyId: Int?
}
