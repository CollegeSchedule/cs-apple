import SwiftUI

struct ListViewItem<T: Hashable&Codable>: Hashable {
    let id: Int
    let item: T
}
