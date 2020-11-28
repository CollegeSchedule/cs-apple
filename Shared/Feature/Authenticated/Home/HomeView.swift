import SwiftUI

struct HomeView: View {
    @EnvironmentObject
    var model: CollegeSchedule.ViewModel
    
    var body: some View {
        ScheduleView(accountId: self.model.account?.account.id, groupId: nil)
    }
}

