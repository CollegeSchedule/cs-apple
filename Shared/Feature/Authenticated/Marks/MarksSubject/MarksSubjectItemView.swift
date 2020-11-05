import SwiftUI

struct MarksSubjectItemView: View {
    let item: MarksSubjectView.SubjectItem
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4) {
                Text(self.item.subject)
                    .font(.system(size: 10, weight: .regular, design: .default))
                Text(self.item.teacher)
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .foregroundColor(Color("MarksSubjectText"))
            }
            Spacer()
            
            HStack(spacing: 20) {
                Image(systemName: "checkmark")
                    .foregroundColor(.green)
                Text(self.item.rating)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke()
                    .foregroundColor(.green)
            )
        }
    }
}
