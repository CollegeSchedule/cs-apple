enum RequestError: Error {
	case local
	case remote(Int)
}
