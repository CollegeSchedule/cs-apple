import Foundation
import Combine
import Security
import CommonCrypto
import KeychainSwift

class Agent: ObservableObject {
    private let session: URLSession = .shared
    private let keychain: KeychainToken = KeychainToken()
    
    private let base: URL = URL(string: "https://api.whywelive.me:2096")!
    private let token: String = "8d181a53-f87b-4377-a057-cd07c49af82f"
    private let secret: String = "3162c1b0-e25f-4b7d-9c2d-d99096d9a984"
    
//    private let base: URL = URL(string: "http://localhost:5000")!
//    private let token: String = "f9540083-9e4d-447f-bd29-4fd5255e14e2"
//    private let secret: String = "4d6f8818-0e65-4cad-9d4e-0075de59174a"
    
    private var access: String = "TEST"
    private var refresh: String = "TEST"
    
    private var headers: [String: Any] = [:]
    
    func run<T: Codable>(
        _ path: String,
        
        method: HTTPMethod = .get,
        params: [String: Any] = [:],
        headers: [String: Any] = [:],
        
        decoder: JSONDecoder = JSONDecoder(),
        type: AuthenticationType = .account
    ) -> AnyPublisher<APIResult<T>, Never> {
        var request = URLRequest.init(
            self.base.appendingPathComponent(path),
            method: method,
            params: params,
            headers: ((type == .account)
                        ? [
                            "accessToken": self.access
                        ] : [
                            "appToken": self.token,
                            "appSecret": self.secret
                        ]
            ).merging(headers) {
                (current, _) in current
            }
        )
                
        if method != .get {
            request.httpBody = try! JSONSerialization.data(
                withJSONObject: params
            )
        }
        
        return self.request(request)
    }
    
    private func request<T: Codable>(
        _ request: URLRequest
    ) -> AnyPublisher<APIResult<T>, Never> {
        return self.session
            .dataTaskPublisher(
                for: request
            )
            .map {
                return $0.data
            }
            .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
            .flatMap { result -> AnyPublisher<APIResult<T>, Never> in
                guard let data = result.data, result.status else {
                    guard result.error!.code == 4 else {
                        return Just(APIResult.error(result.error!))
                            .eraseToAnyPublisher()
                    }
                    
                    guard result.error!.code == 4,
                          request.description.contains("/authentication/token/")
                    else {
                        return AuthenticationService()
                            .refreshToken(token: self.refresh)
                            .flatMap { (
                                result: APIResult<AuthenticationEntity>
                            ) -> AnyPublisher<APIResult<T>, Never> in
                                if case let .success(authentication) = result {
                                    return self.request(
                                        request.authenticate(
                                            token: authentication.access.token
                                        )
                                    )
                                }
                                
                                return Just(APIResult.error(.init()))
                                    .eraseToAnyPublisher()
                            }
                            .eraseToAnyPublisher()
                    }
                    
                    // MARK: we should go to main screen
                    
                    return Just(.error(.init(code: -1)))
                        .eraseToAnyPublisher()
                }
                
                // if response succed and method is authentication
                if result.status,
                   request.description.contains("/authentication/") {
                    let authentication = result.data as! AuthenticationEntity
                    
                    self.access = authentication.access.token
                    self.refresh = authentication.refresh.token
                    
                    self.keychain.setKeychainToken(token: self.access, key: "accessToken")
                    self.keychain.setKeychainToken(token: self.refresh, key: "refreshToken")
                }
                                
                return Just(APIResult.success(data))
                    .eraseToAnyPublisher()
            }
            .catch { error -> Just<APIResult<T>> in
                return Just(.error(APIError()))
            }
            .subscribe(on: Scheduler.background)
            .receive(on: Scheduler.main)
            .share()
            .eraseToAnyPublisher()
    }
    
    //MARK: return hashing Int
    func sha256(data : String) -> String {
        let date = data.data(using: .utf8)!
        let st = date.hashValue
        return st.description
    }
    
    //MARK: return hashing String
    func sha256Data (data : Data) -> String {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        //MARK: Возвращает хешированное значение
        return hash.map { String(format: "%02hhx", $0) }.joined()
        
        //MARK: Возвращает хешированное значение в виде цифр
        //return hash.map { String($0) }.joined()
    }
    
    func trash(){
//        let hashingToken = ""
//        let keychainItem = [
//            kSecValueData: hashingToken,
//            kSecAttrAccount: "iamstillhere",
//            kSecAttrServer: "dragoroma.ru",
////                        kSecAttrCanDecrypt: TLS_ECDH_ECDSA_WITH_AES_128_GCM_SHA256,
////                        kSecAttrCertificateEncoding: TLS,
//            kSecClass: kSecClassInternetPassword,
//            kSecReturnData: true
//        ] as CFDictionary
//
//        var ref: AnyObject?
//
//        print(keychainItem)
//
//        let update = SecItemUpdate(keychainItem, [kSecValueData: hashingToken] as CFDictionary)
//        let status = SecItemAdd(keychainItem, &ref)
//        print("Status: \(status)")
//        print("Update: \(update)")
//        print("SHA256Data: \(hashingToken)")
    }
    
    // MARK: TODO: REFACTOR
//    public static var agent: Agent = Agent()
//    @Published var agent: Agent
}

class KeychainToken{
    
    private let keychain = KeychainSwift()
    
    func setKeychainToken(token: String, key: String){
        keychain.set(token, forKey: key, withAccess: .accessibleWhenUnlocked)
    }
    
    func getKeychainToken(key: String) -> String{
        return keychain.get(key) ?? "Error"
    }
    
    func deletekeychainToken(key: String){
        keychain.delete(key)
    }
    
    func allKeysKeychain() -> [String] {
        return keychain.allKeys
    }
    
    func removeAllKeychain(){
        keychain.clear()
    }
    
}
