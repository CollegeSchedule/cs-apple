import Foundation
import Combine
import SwiftUI

protocol NewsServiceType {
    func get(
        offset: Int,
        limit: Int,
        search: String?
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<NewsEntity>>, Never>
}

final class NewsService: NewsServiceType {
    @Environment(\.agent)
    var agent: Agent
    
    func get(
        offset: Int = 0,
        limit: Int = 30,
        search: String? = nil
    ) -> AnyPublisher<APIResult<CollectionMetaResponse<NewsEntity>>, Never> {
        self.agent.run(
            "/news/",
            params: [
                "offset": offset,
                "limit": limit,
                "search": search ?? ""
            ]
        )
    }
}

struct NewsServiceKey: EnvironmentKey {
    static let defaultValue: NewsService = NewsService()
}

extension EnvironmentValues {
    var newsService: NewsService {
        get {
            self[NewsServiceKey.self]
        }
        set {
            self[NewsServiceKey.self] = newValue
        }
    }
}
