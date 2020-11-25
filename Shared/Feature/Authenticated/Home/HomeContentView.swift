import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject
    var model: HomeView.ViewModel

    @State
        private var day: String = Date().today
        
        @State
        private var items: [ScheduleItem] = [
            .init(
                startLes: "10:50",
                endLes: "12:00",
                lesson: "History",
                classroom: "309"
            ),
            .init(
                startLes: "10:50",
                endLes: "12:00",
                lesson: "History",
                classroom: "309"
            ),
            .init(
                startLes: "10:50",
                endLes: "12:00",
                lesson: "History",
                classroom: "309"
            ),
            .init(
                startLes: "10:50",
                endLes: "12:00",
                lesson: "History",
                classroom: "309"
            ),
            .init(
                startLes: "10:50",
                endLes: "12:00",
                lesson: "History",
                classroom: "309"
            ),
            .init(
                startLes: "10:50",
                endLes: "12:00",
                lesson: "History",
                classroom: "309"
            )
        ]
 
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false ) {
                                HStack{
                                    ForEach(Date().scheduleTimeline(), id: \.self) { week in
                                        VStack {
                                            Text(week.prefix(2))
                                            Text(self.dateFormat(week).lowercased())
                                        }
                                        .padding(4)
                                        .background(week == self.day ? Color.blue : Color.clear)
                                        .cornerRadius(12)
                                        .onTapGesture {
                                            self.day = week
                                        }
                                    }
                                }
                            }
            
            ForEach(self.model.homeStatus, id: \.self) { item in
                HomeItemView(item: item)
            }
        }
    }

    private func dateFormat(_ day: String) -> String {
        let form = DateFormatter()
        form.dateFormat = "dd MMMM yyyy"
        let dateobj = form.date(from: day)
        form.dateFormat = "EE"

        return form.string(from: dateobj!)
    }

    private func week() -> String {
        if Date().scheduleTimeline()[7] > self.day {
            return "Нечетная"
        } else {
            return "Четная"
        }
    }

    struct ScheduleItem: Hashable{
        let startLes: String
        let endLes: String
        let lesson: String
        let classroom: String
    }
}
