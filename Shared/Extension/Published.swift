import Foundation
import Combine
import SwiftUI

private var cancellableSet: Set<AnyCancellable> = []

extension Published where Value: Codable {
    init(
        wrappedValue defaultValue: Value,
        _ key: String,
        store: UserDefaults = .standard
    ) {
        if let data = store.data(forKey: key),
           let value = try? JSONDecoder().decode(Value.self, from: data) {
            self.init(initialValue: value)
        } else {
            self.init(initialValue: defaultValue)
        }

        projectedValue
            .sink { newValue in
                let data = try? JSONEncoder().encode(newValue)
                store.set(data, forKey: key)
                store.synchronize()
            }
            .store(in: &cancellableSet)
  }
}
