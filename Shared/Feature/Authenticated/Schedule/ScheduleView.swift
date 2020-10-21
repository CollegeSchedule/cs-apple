import SwiftUI

struct ScheduleView: View {
    let week: [String] = ["пн","вт","ср","чт","пт","сб","вс"]
    
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
                        ForEach(self.getDate(), id: \.self) { day in
                            VStack{
                                Text(day)
                                    .font(.title2)
                                Text(week[0])
                                    .font(.title3)
                            }
                        }
                    }
                }
            }
            .padding()
            
            VStack{
                Divider()
                HStack{
                    Text("Monday, 19 october")
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
    
    func getDate() -> [String] {
        let date = Date()
        let formatter = DateFormatter()
        var dateWeek: [String] = []
        
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.setLocalizedDateFormatFromTemplate("dd")
        
        
        for i in 0...14{
            let nextDay = Calendar.current.date(byAdding: .day, value: i, to: date)
            dateWeek.append(formatter.string(from: nextDay!))
        }

        return dateWeek
    }
}
