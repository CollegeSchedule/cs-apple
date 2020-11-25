import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject
    var model: HomeView.ViewModel

    @State
    private var day: String = Date().today
    
    @State
    private var currentDay: String?
 
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false ) {
                HStack{
                    ForEach(Date().scheduleTimeline(), id: \.self) { week in
                        VStack {
                            Text(week.prefix(2))
                            Text(self.dateFormat(week, type: "EE").lowercased())
                        }
                        .padding(8)
                        .background(week == self.day ? Color.blue : Color.clear)
                        .cornerRadius(12)
                        .onTapGesture {
                            self.day = week
                            self.currentDay = self.dateFormat(self.day, type: "e")
                        }
                        .onAppear {
                            self.currentDay = self.dateFormat(self.day, type: "e")
                        }
                    }
                }
            }
            
            VStack {
                ForEach(self.model.homeStatus.filter{ result in
                    return result.day == Int(self.currentDay!)!
                }, id: \.self) { item in
                    HomeItemView(item: item)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }

    private func dateFormat(_ day: String, type: String) -> String {
        let form = DateFormatter()
        form.dateFormat = "dd MMMM yyyy"
        if type == "EE" {
            let dateobj = form.date(from: day)
            form.dateFormat = "EE"
            
            return form.string(from: dateobj!)
        } else {
            let dateobj = form.date(from: day)
            form.dateFormat = "e"
            
            return form.string(from: dateobj!)
        }
        
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
