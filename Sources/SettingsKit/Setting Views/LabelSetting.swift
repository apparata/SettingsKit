//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - LabelSetting

public struct LabelSetting<Label: View, Value: View>: View {

    let icon: SettingIcon?
    
    let label: Label
    
    let value: Value?

    public var body: some View {
        HStack {
            icon
            label
            if let value = value {
                Spacer()
                value
            }
        }
    }

    public init(label: Label, value: Value?, icon: SettingIcon? = nil) {
        self.label = label
        self.value = value
        self.icon = icon
    }
}

extension LabelSetting where Value == EmptyView {
    public init(label: Label, icon: SettingIcon? = nil) {
        self.label = label
        self.value = nil
        self.icon = icon
    }
}

extension LabelSetting where Label == Text, Value == Text {
    public init(_ title: String, value: String? = nil, icon: SettingIcon? = nil) {
        self.label = Text(title)
        self.value = value.map(Text.init)
        self.icon = icon
    }
}

// MARK: - Preview

struct LabelValueSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                Section {
                    LabelSetting("Title")
                    LabelSetting("Title", icon: SettingIcon("shippingbox.fill"))
                    LabelSetting("Title",
                                 icon: SettingIcon("crown.fill", color: .green))
                    NavigationLink(destination: Text("")) {
                        LabelSetting("Title")
                    }
                    NavigationLink(destination: Text("")) {
                        LabelSetting("Title",
                                     icon: SettingIcon("mosaic.fill", color: .orange))
                    }
                }
                Section {
                    NavigationLink(destination: Text("")) {
                        LabelSetting("Title", value: "Value")
                    }
                    NavigationLink(destination: Text("")) {
                        LabelSetting("Title",
                                     value: "Value",
                                     icon: SettingIcon("bus.fill"))
                    }
                }
                Section {
                    LabelSetting(label: Text("Title"))
                    LabelSetting(label: Text("Title"),
                                 icon: SettingIcon("shippingbox.fill"))
                    LabelSetting(label: Text("Title"),
                                 value: Text("Value"))
                    LabelSetting(label: Text("Title"),
                                 value: Text("Value"),
                                 icon: SettingIcon("shippingbox.fill"))
                }
            }.navigationTitle("Settings")
        }
    }
}
