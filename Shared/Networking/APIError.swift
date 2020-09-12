struct APIError: Codable {
    var code: Int = 0
    var message: String = "Unknown exception."
    var description: String = "Unknown exception."
}
