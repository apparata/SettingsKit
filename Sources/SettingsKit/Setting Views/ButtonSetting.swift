//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - ButtonSetting

public struct ButtonSetting<Label: View>: View {
    
    let icon: SettingIcon?

    let label: Label
    
    let color: Color?
    
    let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            if let icon = icon {
                HStack {
                    icon
                    label
                        .foregroundColor(color ?? .primary)
                }
            } else {
                label
                    .foregroundColor(color ?? .accentColor)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    public init(label: Label, color: Color? = nil, icon: SettingIcon? = nil, action: @escaping () -> Void) {
        self.label = label
        self.color = color
        self.icon = icon
        self.action = action
    }
}


extension ButtonSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, color: Color? = nil, icon: SettingIcon? = nil, action: @escaping () -> Void) {
        self.label = Text(titleKey)
            .fontWeight(icon == nil ? .semibold : .regular)
        self.color = color
        self.icon = icon
        self.action = action
    }
    
    public init<S: StringProtocol>(_ title: S, color: Color? = nil, icon: SettingIcon? = nil, action: @escaping () -> Void) {
        self.label = Text(title)
            .fontWeight(icon == nil ? .semibold : .regular)
        self.color = color
        self.icon = icon
        self.action = action
    }
}

// MARK: - Preview

struct ButtonSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                Section {
                    ButtonSetting("Title") {
                        print("Hello")
                    }
                    ButtonSetting("Title", icon: SettingIcon("shippingbox.fill")) {
                        print("Hello")
                    }
                    ButtonSetting(label: Text("Title").fontWeight(.semibold)) {
                        print("Hello")
                    }
                }
            }.navigationTitle("Settings")
        }
    }
}
