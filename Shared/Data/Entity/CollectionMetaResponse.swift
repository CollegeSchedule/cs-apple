import Foundation

struct CollectionMetaResponse<T: Codable&Hashable>: Codable, Hashable {
    let meta: CollectionMeta?
    let items: [T]
    
    struct CollectionMeta: Codable, Hashable {
        let count: Int
        let totalCount: Int?
    }
}
