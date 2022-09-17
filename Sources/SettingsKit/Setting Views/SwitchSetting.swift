//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - SwitchSetting

public struct SwitchSetting<Label: View>: View {

    let icon: SettingIcon?
    
    let label: Label
    
    @Binding var isOn: Bool
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: 8) {
                icon
                label
            }
        }
    }
    
    public init(label: Label, isOn: Binding<Bool>, icon: SettingIcon? = nil) {
        self.label = label
        self._isOn = isOn
        self.icon = icon
    }
}

extension SwitchSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, isOn: Binding<Bool>, icon: SettingIcon? = nil) {
        self.label = Text(titleKey)
        self._isOn = isOn
        self.icon = icon
    }

    public init<S: StringProtocol>(_ title: S, isOn: Binding<Bool>, icon: SettingIcon? = nil) {
        self.label = Text(title)
        self._isOn = isOn
        self.icon = icon
    }
}

// MARK: - Preview

struct SwitchSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                Section {
                    SwitchSetting("Title", isOn: .constant(false))
                    SwitchSetting("Title", isOn: .constant(true))
                    SwitchSetting("Title",
                                  isOn: .constant(true),
                                  icon: SettingIcon("pc"))
                    SwitchSetting("Title",
                                  isOn: .constant(false),
                                  icon: SettingIcon("cpu", color: .green))
                }
            }.navigationTitle("Settings")
        }
    }
}
