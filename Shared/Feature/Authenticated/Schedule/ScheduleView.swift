import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject private var state: CollegeSchedule.ViewModel
    @EnvironmentObject private var settings: CollegeSchedule.SettingsModel
    
    var body: some View {
        VStack {
            ErrorView(
                animation: "who",
                title: "Кто ты?",
                description: "Здесь я могу показывать расписание определенной группы или преподавателя — тебе тогда придется указать свое имя, тыкнув на кнопку!"
            )
            
            Spacer()
            
            Button(action: {}) {
                Text("Сделать выбор")
            }.rounded().padding(.vertical)
            
        }.modifier(BackgroundModifier(color: .scheduleSectionListColor)).padding()
    }
}


//ScheduleComponentView(
//    accountId: account.account.id,
//    groupId: nil,
//    mode: account.account.label == .teacher ? .teacher : .student
//)
