import SwiftUI

struct SettingsAppearanceView: View {
    @EnvironmentObject
    var state: CollegeSchedule.ViewModel
    
    @ObservedObject
    var model: SettingsAppearanceView.ViewModel = .init()
            
    @State
    var items: [String] = ["authenticated.settings.appearance.light", "authenticated.settings.appearance.dark"]
    
    @State
    var selection: Int = 0
        
    var body: some View {
        Form {
            List {
                Section(
                    header: Text(LocalizedStringKey("authenticated.settings.appearance.theme")),
                    footer: Text(LocalizedStringKey("authenticated.settings.appearance.system_design"))
                ) {
                    Toggle(
                        LocalizedStringKey("authenticated.settings.appearance.system"),
                        isOn: self.$state.isSystemAppearance
                    )
                }
                
                if !self.state.isSystemAppearance {
                    Section(
                        footer: Text(LocalizedStringKey("auhtenticated.settings.appearance.selected_design"))
                    ) {
                        InlinePicker(
                            items: self.items,
                            selection: self.$state.currentAppearance
                        )
                    }
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}
