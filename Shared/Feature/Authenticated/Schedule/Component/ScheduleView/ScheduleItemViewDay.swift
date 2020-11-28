import SwiftUI

struct ScheduleItemViewDay: View {
    @State
    var days: [ScheduleView.WeekDay]
    
    @Binding
    var currentIndex: Int
    
    @Binding
    var today: Int
    
    var body: some View {
        HStack {
            ForEach(self.days, id: \.id) { item in
                Spacer()
                Button(action: {
                    self.currentIndex = item.id
                }) {
                    VStack {
                        Text(item.name)
                        Text(item.day.description)
                            .frame(width: 32, height: 32)
                            .background(self.dayBackgroundView(item))
                    }
                }
                Spacer()
            }
        }
    }
    
    private func dayBackgroundView(_ day: ScheduleView.WeekDay) -> AnyView {
        if day.id == self.currentIndex {
            return Circle().foregroundColor(.blue).eraseToAnyView()
        } else if day.day == self.today {
            return Circle().stroke().foregroundColor(.blue).eraseToAnyView()
        } else {
            return Circle().foregroundColor(.clear).eraseToAnyView()
        }
    }
}
