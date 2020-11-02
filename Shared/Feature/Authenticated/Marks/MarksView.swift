import SwiftUI

struct MarksView: View {
    @State
    private var selection = 0
    
    var body: some View {
        VStack {
            Picker("", selection: self.$selection) {
                Text("By Date")
                    .tag(0)
                Text("By subject")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if self.selection == 0 {
                Text("ff")
            }
            else{
                MarkslSubjectView()
            }
        }
    }
    struct SubjectItem: Hashable {
        let subject: String
        let teacher: String
        let rating: String
    }
}


