import SwiftUI

struct ScheduleItemView: View {
    let item: ScheduleSubjectEntity
    let isTeacher: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("8:30")
                Text("10:05")
            }
            
            VStack {
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.yellow)
                        .frame(maxWidth: 6, maxHeight: 40)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                        .frame(maxWidth: 6, maxHeight: 20)
                }.padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                Text(self.item.subject.name)
                    .truncationMode(.tail)
                    .lineLimit(1)
                Text(self.isTeacher ? self.item.group.print! : self.item.teacher.print)
                    .truncationMode(.tail)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text(self.item.classroom.name)
        }
    }
}
