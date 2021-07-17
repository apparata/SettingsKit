//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - LinkSetting

public struct LinkSetting<Label: View>: View {
    
    let icon: SettingIcon?

    let label: Label
    
    let color: Color?
    
    let url: URL
    
    public var body: some View {
        Link(destination: url) {
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
    
    public init(label: Label, url: URL, color: Color? = nil, icon: SettingIcon? = nil) {
        self.label = label
        self.icon = icon
        self.color = color
        self.url = url
    }
}

extension LinkSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, url: URL, color: Color? = nil, icon: SettingIcon? = nil) {
        self.label = Text(titleKey)
            .fontWeight(icon == nil ? .semibold : .regular)
        self.color = color
        self.icon = icon
        self.url = url
    }
    
    public init<S: StringProtocol>(_ title: S, url: URL, color: Color? = nil, icon: SettingIcon? = nil) {
        self.label = Text(title)
            .fontWeight(icon == nil ? .semibold : .regular)
        self.color = color
        self.icon = icon
        self.url = url
    }
}

// MARK: - Preview

struct LinkSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                Section {
                    LinkSetting("Github",
                                url: URL(string: "https://github.com")!)
                    LinkSetting("Github",
                                url: URL(string: "https://github.com")!,
                                icon: SettingIcon("shippingbox.fill"))
                }
                Section {
                    LinkSetting(label: Text("Github").fontWeight(.semibold),
                                url: URL(string: "https://github.com")!)
                    LinkSetting(label: Text("Github"),
                                url: URL(string: "https://github.com")!,
                                icon: SettingIcon("shippingbox.fill"))
                }
            }.navigationTitle("Settings")
        }
    }
}
