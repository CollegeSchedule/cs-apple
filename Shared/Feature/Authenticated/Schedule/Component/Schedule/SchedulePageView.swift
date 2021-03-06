import SwiftUI

struct SchedulePageView: View {
    @State var data: [ScheduleComponentView.ScheduleViewDayResult]
    @State var mode: SchedulePresentationMode
    @State var sheetAllowed: Bool
    
    var body: some View {
        List {
            ForEach(self.data.sorted(by: { $0.day < $1.day }), id: \.self) { item in
                Section(header: self.header(item: item)) {
                    ForEach(item.items, id: \.id) { lesson in
                        ScheduleLessonView(item: lesson, mode: self.mode, sheetAllowed: self.sheetAllowed)
                    }
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
    
    private func header(item: ScheduleComponentView.ScheduleViewDayResult) -> some View {
        HStack {
            Text(item.header.uppercased()).foregroundColor(.gray).font(.footnote)
            
            Spacer()
            
            if (item.today) {
                Text("Сегодня")
            }
        }
    }
}

