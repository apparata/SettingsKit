//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - LinkSetting

public struct LinkSetting<Label: View>: View {
    
    let icon: SettingIcon?

    let label: Label
    
    let url: URL
    
    public var body: some View {
        Link(destination: url) {
            if let icon = icon {
                HStack {
                    icon
                    label
                        .foregroundColor(Color.primary)
                }
            } else {
                label
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    public init(label: Label, url: URL, icon: SettingIcon? = nil) {
        self.label = label
        self.icon = icon
        self.url = url
    }
}

extension LinkSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, url: URL, icon: SettingIcon? = nil) {
        self.label = Text(titleKey)
            .fontWeight(icon == nil ? .semibold : .regular)
        self.icon = icon
        self.url = url
    }
    
    public init<S: StringProtocol>(_ title: S, url: URL, icon: SettingIcon? = nil) {
        self.label = Text(title)
            .fontWeight(icon == nil ? .semibold : .regular)
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
