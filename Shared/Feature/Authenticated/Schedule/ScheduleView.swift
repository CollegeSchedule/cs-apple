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
						ForEach(self.date.scheduleTimeline(), id: \.self){ week in
							VStack{
								Text(week.prefix(2))
								Text("md")
							}
							.onTapGesture{
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
					Text("\(self.day)")
                    Spacer()
                    Text("Week")
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
    struct ScheduleItem: Hashable{
        let startLes: String
        let endLes: String
        let lesson: String
        let classroom: String
    }
}
