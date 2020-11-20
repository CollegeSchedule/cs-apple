import SwiftUI

struct ScheduleView: View {
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
        VStack{
            Divider()
                .padding(.horizontal)
            VStack{
                ScrollView(.horizontal, showsIndicators: false ) {
					HStack{
                        ForEach(self.date.scheduleTimeline(), id: \.self) { week in
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
            }
            .padding()
            
            VStack{
                Divider()
                HStack{
                    Text(self.day.dropLast(4))
                    Spacer()
                    Text(self.week())
                }
                .padding(.horizontal)
                Divider()
            }
            
            ScrollView(showsIndicators: false) {
                ForEach(self.items, id: \.self){ item in
                    ScheduleItemView(item: item)
                }
            }
            Spacer()
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
