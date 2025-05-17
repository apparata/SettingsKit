//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - DisclosureButtonSetting

public struct DisclosureButtonSetting<Label: View>: View {

    let icon: SettingIcon

    let label: Label
    
    let color: Color?
    
    let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            HStack {
                icon
                label
                    .foregroundColor(color ?? .primary)
                Spacer()
                SettingChevron()
            }
        }
    }
    
    public init(label: Label, color: Color? = nil, icon: SettingIcon, action: @escaping () -> Void) {
        self.label = label
        self.color = color
        self.icon = icon
        self.action = action
    }
}


extension DisclosureButtonSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, color: Color? = nil, icon: SettingIcon, action: @escaping () -> Void) {
        self.label = Text(titleKey)
            .fontWeight(.regular)
        self.color = color
        self.icon = icon
        self.action = action
    }
    
    public init<S: StringProtocol>(_ title: S, color: Color? = nil, icon: SettingIcon, action: @escaping () -> Void) {
        self.label = Text(title)
            .fontWeight(.regular)
        self.color = color
        self.icon = icon
        self.action = action
    }
}

// MARK: - Preview

struct DisclosureButtonSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                Section {
                    DisclosureButtonSetting("Title", icon: SettingIcon("shippingbox.fill")) {
                        print("Hello")
                    }
                    DisclosureButtonSetting(label: Text("Title").fontWeight(.semibold), icon: SettingIcon("shippingbox.fill")) {
                        print("Hello")
                    }
                }
            }.navigationTitle("Settings")
        }
    }
}
