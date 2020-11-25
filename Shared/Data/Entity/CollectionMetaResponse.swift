import Foundation

struct CollectionMetaResponse<T: Codable>: Codable {
    let meta: CollectionMeta?
    let items: [T]
    
    struct CollectionMeta: Codable {
        let count: Int
        let totalCount: Int?
    }
}
