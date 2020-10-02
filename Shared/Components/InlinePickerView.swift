import SwiftUI

struct InlinePicker: View {
    let items: [String]
    
    @Binding
    var selection: Int
    
    var body: some View {
        ForEach(0..<self.items.endIndex) { index in
            Button(action: {
                self.selection = index
            }) {
                Label {
                    HStack {
                        Text(self.items[index])
                            .foregroundColor(.primary)
//                            .onTapGesture {
//                                print(index)
//                            }
                        
                        Spacer()
                        
                        if self.selection == index {
                            Image(systemName: "checkmark")
                        }
                    }
                } icon: {
                    EmptyView()
                }.labelStyle(TitleOnlyLabelStyle())
            }.buttonStyle(InlinePickerButtonStyle())
        }
    }
}

struct InlinePickerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.accentColor)
            .listRowBackground(Color.inlineBackgroundColor)
            .background(Color.inlineBackgroundColor)
    }
}

extension Color {
    fileprivate static let inlineBackgroundColor: Color = Color(
        UIColor { (traits) -> UIColor in
            // Return one of two colors depending on light or dark mode
            return traits.userInterfaceStyle == .dark
                ? UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
                : UIColor.white
        }
    )
}
