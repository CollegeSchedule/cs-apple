struct Authentication: Codable {
    let access: Token
    let refresh: Token
    
    struct Token: Codable {
        let token: String
        let type: TokenType
        let lifetime: Int
        let createdAt: Int
    }
    
    enum TokenType: String, Codable {
        case access  = "access"
        case refresh = "refresh"
    }
}
