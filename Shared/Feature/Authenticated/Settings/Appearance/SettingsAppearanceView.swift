import SwiftUI

struct SettingsAppearanceView: View {
    @AppStorage("settings_appearance_is_system")
    var isSystemAppearance: Bool = true
    
    @AppStorage("settings_appearance_current")
    var currentAppearance: Int = 0
            
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
                    Toggle("Системное", isOn: self.$isSystemAppearance)
                }

                if !self.isSystemAppearance {
                    Section(footer: Text("Будет использоваться выбранное оформление. Системное оформление игнорируется.")) {
                        InlinePicker(items: self.items, selection: self.$selection)
                    }
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}
