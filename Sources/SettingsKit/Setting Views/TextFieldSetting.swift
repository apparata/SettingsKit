//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - TextFieldSetting

/// Title and text field setting.
///
/// *Example:*
///
/// ```
/// TextFieldSetting("Log Filename",
///                  value: $settings.logFilename)
/// ```
public struct TextFieldSetting<Label: View>: View {
    
    let icon: SettingIcon?

    let label: Label
    
    @Binding var value: String

    let placeholder: String
    
    public var body: some View {
        HStack {
            icon
            label
            Spacer()
            TextField(placeholder, text: $value)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.secondary)
                .frame(maxWidth: 100)
        }
    }
    
    public init(label: Label, value: Binding<String>, placeholder: String = "", icon: SettingIcon? = nil) {
        self.label = label
        self._value = value
        self.placeholder = placeholder
        self.icon = icon
    }
}

extension TextFieldSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, value: Binding<String>, placeholder: String = "", icon: SettingIcon? = nil) {
        self.label = Text(titleKey)
        self._value = value
        self.placeholder = placeholder
        self.icon = icon
    }

    public init<S: StringProtocol>(_ title: S, value: Binding<String>, placeholder: String = "", icon: SettingIcon? = nil) {
        self.label = Text(title)
        self._value = value
        self.placeholder = placeholder
        self.icon = icon
    }
}

// MARK: - Preview

struct TitleEditableTextSetting_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            Form {
                Section {
                    TextFieldSetting("Title",
                                     value: .constant("Value"))
                    TextFieldSetting("Title",
                                     value: .constant("Value"),
                                     icon: SettingIcon("command.circle.fill"))
                }
            }.navigationTitle("Settings")
        }
    }
}
