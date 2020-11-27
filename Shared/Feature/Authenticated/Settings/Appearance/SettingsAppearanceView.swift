import SwiftUI

struct SettingsAppearanceView: View {
    @EnvironmentObject
    var state: CollegeSchedule.ViewModel
    
    @ObservedObject
    var model: SettingsAppearanceView.ViewModel = .init()
            
    @State
    var items: [String] = ["Всегда светлая", "Всегда темная"]
    
    @State
    var selection: Int = 0
        
    var body: some View {
        Form {
            List {
                Section(
                    header: Text("Светлая и темная тема"),
                    footer: Text("При включённом индикаторе повторяется системное оформление.")
                ) {
                    Toggle("Системное", isOn: self.$state.isSystemAppearance)
                }
                
                if !self.state.isSystemAppearance {
                    Section(footer: Text("Будет использоваться выбранное оформление. Системное оформление игнорируется.")) {
                        InlinePicker(items: self.items, selection: self.$state.currentAppearance)
                    }
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
