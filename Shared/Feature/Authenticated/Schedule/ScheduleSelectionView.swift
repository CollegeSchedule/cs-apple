import SwiftUI

struct ScheduleSelectionView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            ErrorView(
                animation: "who",
                title: "Кто ты?",
                description: "Здесь я могу показывать расписание определенной группы или преподавателя — тебе тогда придется указать свое имя, тыкнув на кнопку!"
            )
            
            Spacer()
            
            Button(action: {
                self.isPresented = true
            }) {
                Text("Сделать выбор")
            }.rounded().padding(.vertical)
        }.padding()
    }
}

