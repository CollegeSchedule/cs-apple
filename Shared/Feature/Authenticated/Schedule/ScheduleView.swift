import SwiftUI
import SPAlert

struct ScheduleView: View {
    @EnvironmentObject private var state: CollegeSchedule.ViewModel
    @EnvironmentObject private var settings: CollegeSchedule.SettingsModel
    
    @State
    var isPresented: Bool = false
    
    var body: some View {
        VStack {
            if self.settings.scheduleId == 0 {
                ScheduleSelectionView(isPresented: self.$isPresented)
            } else if self.settings.scheduleId > 0 {
                ScheduleComponentView(accountId: self.settings.scheduleId, groupId: nil, mode: .teacher, sheetAllowed: true)
            } else {
                ScheduleComponentView(accountId: nil, groupId: abs(self.settings.scheduleId), mode: .student, sheetAllowed: true)
            }
        }
        .navigationTitle(self.title)
        .modifier(BackgroundModifier(color: .scheduleSectionListColor))
        .sheet(isPresented: self.$isPresented, content: {
            NavigationView {
                SearchComponentView(navigationAllowed: false)
                .ignoresSafeArea(SafeAreaRegions.all, edges: .bottom)
                .navigationTitle("Выбор расписания")
                .navigationBarTitleDisplayMode(.inline)
            }
        })
        .onChange(of: self.settings.scheduleId, perform: { value in
            if value != 0 {
                self.isPresented = false
            }
        })
    }
    
    private var title: String {
        if self.settings.scheduleId != 0 {
            // todo: refactor the thing, do fetch
            return self.settings.scheduleTitle
        } else {
            return "Расписание"
        }
    }
}

