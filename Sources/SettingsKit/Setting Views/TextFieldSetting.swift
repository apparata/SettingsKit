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
    
    let onEditingChanged: (Bool) -> Void
    
    let onCommit: () -> Void
    
    public var body: some View {
        HStack {
            icon
            label
            Spacer()
            TextField(placeholder, text: $value, onEditingChanged: onEditingChanged, onCommit: onCommit)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.secondary)
                .frame(maxWidth: 100)
        }
    }
    
    public init(label: Label, value: Binding<String>, placeholder: String = "", icon: SettingIcon? = nil, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = { }) {
        self.label = label
        self._value = value
        self.placeholder = placeholder
        self.icon = icon
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
    }
}

extension TextFieldSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, value: Binding<String>, placeholder: String = "", icon: SettingIcon? = nil, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = { }) {
        self.label = Text(titleKey)
        self._value = value
        self.placeholder = placeholder
        self.icon = icon
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
    }

    public init<S: StringProtocol>(_ title: S, value: Binding<String>, placeholder: String = "", icon: SettingIcon? = nil, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = { }) {
        self.label = Text(title)
        self._value = value
        self.placeholder = placeholder
        self.icon = icon
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
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
