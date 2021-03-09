enum APIResult<T> {
    case success(T)
    case loading
    case empty
    case error(APIError)
}

extension APIResult: Equatable {
    static func ==(lhs: APIResult, rhs: APIResult) -> Bool {
        switch (lhs, rhs) {
            case (.success, .success): return true
            case (.loading, .loading): return true
            case (.empty, .empty): return true
            case (.error, .error): return true
            default: return false
        }
    }
}
