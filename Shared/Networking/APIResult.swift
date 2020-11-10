enum APIResult<T> {
    case success(T)
    case loading
    case empty
    case error(APIError)
}
