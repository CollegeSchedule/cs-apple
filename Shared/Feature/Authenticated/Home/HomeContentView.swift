import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject
    var model: HomeView.ViewModel
    
    let date: Date = Date()

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
            ForEach(self.items, id: \.self) { item in
                HomeItemView(item: item)
            }
        }.padding()
    }

    private func dateFormat(_ day: String) -> String {
        let form = DateFormatter()
        form.dateFormat = "dd MMMM yyyy"
        let dateobj = form.date(from: day)
        form.dateFormat = "EE"

        return form.string(from: dateobj!)
    }

    private func week() -> String {
        if self.date.scheduleTimeline()[7] > self.day {
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
