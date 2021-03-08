import SwiftUI

struct ScheduleComponentView: View {
    @ObservedObject
    private var model: ScheduleComponentView.ViewModel
    
    private var mode: SchedulePresentationMode
    private var sheetAllowed: Bool
    
    init(
        accountId: Int? = nil,
        groupId: Int? = nil,
        mode: SchedulePresentationMode,
        sheetAllowed: Bool = true
    ) {
        self.model = .init(accountId: accountId, groupId: groupId)
        self.mode = mode
        self.sheetAllowed = sheetAllowed
    }

    var body: some View {
        TabView(selection: self.$model.selection) {
            VStack {
                APIResultView(result: self.$model.first, empty: { Text("Расписание еще не составлено") }) { result in
                    SchedulePageView(data: result, mode: self.mode, sheetAllowed: self.sheetAllowed)
                }
            }.tag(0)
            
            VStack {
                APIResultView(result: self.$model.second, empty: { Text("Расписание еще не составлено") }) { result in
                    SchedulePageView(data: result, mode: self.mode, sheetAllowed: self.sheetAllowed)
                }
            }.tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear(perform: self.model.fetch)
    }
}
