enum APIResult<T> {
    case success(T)
    case error(APIError)
}
