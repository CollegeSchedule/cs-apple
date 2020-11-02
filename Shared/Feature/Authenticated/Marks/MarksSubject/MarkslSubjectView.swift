import SwiftUI

struct MarkslSubjectView: View {
    @State
    private var items: [MarksView.SubjectItem] = [
        .init(
            subject: "Physics",
            teacher: "Салий Н.А",
            rating: "4"
        ),
        .init(
            subject: "Physics",
            teacher: "Салий Н.А",
            rating: "4"
        ),
        .init(
            subject: "Physics",
            teacher: "Салий Н.А",
            rating: "4"
        ),
        .init(
            subject: "Physics",
            teacher: "Салий Н.А",
            rating: "4"
        )
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(self.items, id: \.self) { item in
                        MarksSubjectItemView(item: item)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(Color("MarksSubject"))
                            )
                            .padding([.horizontal, .top])
                    }
                }
            }
        }
    }
}
