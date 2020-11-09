struct APIResponse<T: Codable>: Codable {
    let status: Bool
    let data: T
    let error: APIError?
}
