import Foundation
import Combine

protocol EntityServiceType {
    associatedtype Entity: Codable & Hashable
    
    func get(
        offset: Int,
        limit: Int,
        search: String?,
        scope: [String]
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<Entity>>, Never>
    
    func delete(id: Int) -> AnyPublisher<APIResult<Entity>, Never>
}
