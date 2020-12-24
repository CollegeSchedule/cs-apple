import SwiftUI

struct ScheduleItemView: View {
    let item: ScheduleSubjectEntity
    let isTeacher: Bool
    let weekdays: ScheduleTimeSubject.Lesson
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text(self.hoursTime(time: self.weekdays.startTime))
                Text(
                    self.hoursTime(
                        time:
                            self.weekdays.startTime
                            + self.weekdays.lengthTime
                    )
                )
            }.frame(width: 50, alignment: .leading)
            
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
                Text(
                    self.isTeacher ?
                        self.item.group.print!
                        : self.item.teacher.print
                )
                .truncationMode(.tail)
                .foregroundColor(.gray)
                .lineLimit(1)
            }
            
            Spacer()
            
            Text(self.item.classroom.name)
        }
    }
    private func hoursTime(time: Int) -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        
        return formatter.string(from: TimeInterval(time * 60))!
    }
}
