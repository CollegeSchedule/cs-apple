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
        TabView {
            VStack {
                APIResultView(result: self.$model.first, empty: {
                    ErrorView(
                        animation: "empty_schedule",
                        title: "Немного позже!",
                        description: "Мы еще не подготовили расписание на текущую неделю, извини.."
                    )
                }) { result in
                    SchedulePageView(data: result, mode: self.mode, sheetAllowed: self.sheetAllowed)
                }
            }
            
            VStack {
                APIResultView(result: self.$model.second, empty: {
                    ErrorView(
                        animation: "empty_schedule",
                        title: "Немного позже!",
                        description: "Мы еще не подготовили расписание на следующую неделю, извини.."
                    )
                }) { result in
                    SchedulePageView(data: result, mode: self.mode, sheetAllowed: self.sheetAllowed)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear(perform: self.model.fetch)
    }
}
