struct AccountMeEntity: Codable, Hashable {
    let account: AccountEntity
    let group: GroupEntity?
    let subgroup: SubgroupEntity?
//    let permissions: AccountMePermissions
//    
//    struct AccountMePermissions: Codable, Hashable {
//        let global: [String: Int]
//        let institution: [String: Int]
//    }
}
