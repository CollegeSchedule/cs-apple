import SwiftUI

struct SettingsAppearanceView: View {
    @EnvironmentObject
    var settings: CollegeSchedule.SettingsModel
    
    var body: some View {
        List {
            Section(header: Text("Расписание")) {
//                Toggle(isOn: self.$settings.lessonShowEmpty) {
//                    Text("Отображать пустые занятий")
//                }

                Toggle(isOn: self.$settings.lessonShowSort) {
                    Text("Отображать номер занятий")
                }.disabled(!self.settings.lessonShowTime)
                
                Toggle(isOn: self.$settings.lessonShowTime) {
                    Text("Отображать время занятий")
                }.disabled(!self.settings.lessonShowSort)
            }
        }.listStyle(InsetGroupedListStyle())
    }
}
