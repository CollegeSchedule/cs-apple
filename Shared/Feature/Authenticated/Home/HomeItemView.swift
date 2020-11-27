import SwiftUI

// MARK: - Move to ScheduleView Component
struct HomeItemView: View {
    let item: ScheduleSubjectEntity
    
    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("10:50")
                    Text("12:00")
                }
                .padding(.trailing)
                
                HStack{
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.green)
                    
                    VStack(alignment: .leading) {
                        Text(self.item.subject.name)
                        // MARK: - Move to localization
                        Text("Аудитория: \(self.item.classroom.name)")
                    }
                }
                Spacer()
                
                VStack(alignment: .center) {
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
}
