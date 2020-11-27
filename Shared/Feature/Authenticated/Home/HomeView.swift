import SwiftUI

// MARK: - Move to Schedule and Name -> extension ScheduleView -> WeekDay
struct WeekDay {
    let id: Int
    let day: Int
    let name: String
}

struct HomeView: View {
    var body: some View {
        ScheduleView(accountId: nil, groupId: nil)
    }
}

