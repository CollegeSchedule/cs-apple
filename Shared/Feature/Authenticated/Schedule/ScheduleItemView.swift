import SwiftUI

struct ScheduleItemView: View {
    let item: ScheduleView.ScheduleItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.item.startLes)
                Text(self.item.endLes)
            }
            .padding(.trailing)
            
            HStack{
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                
                VStack(alignment: .leading) {
                    Text(self.item.lesson)
                    Text("Аудитория: \(self.item.classroom)")
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
