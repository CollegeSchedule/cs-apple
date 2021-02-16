import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject private var state: CollegeSchedule.ViewModel
    @EnvironmentObject private var settings: CollegeSchedule.SettingsModel
    
    var body: some View {
        APIResultView(result: self.$state.account, empty: { EmptyView() }) { account in
            ScheduleComponentView(
                accountId: account.account.id,
                groupId: nil,
                mode: account.account.label == .teacher ? .teacher : .student
            )
        }
        .modifier(BackgroundModifier(color: .scheduleSectionListColor))
    }
}
