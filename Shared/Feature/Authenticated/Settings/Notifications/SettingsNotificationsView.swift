import SwiftUI
import UserNotifications

struct SettingsNotificationsView: View {
    @State var isNotificationEnabled: Bool = false
    @State var notificationTime: Date = Date()
    
    var body: some View {
        List {
            Section(header: Text("Расписание"), footer: Text("Мы будем напоминать вам о занятиях, которые будут проходить на следующий день")) {
                Toggle(isOn: self.$isNotificationEnabled) {
                    Text("Показывать уведомления")
                }
                
                DatePicker(selection: self.$notificationTime, displayedComponents: .hourAndMinute, label: { Text("Время") })
            }
            
            Button(action: {

                
                print("sending?")
                
            }) {
                Text("Тест")
            }
        }.listStyle(InsetGroupedListStyle())
    }
}
