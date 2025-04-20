//
//  Copyright © 2025 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - PushSetting

public struct PushSetting<Destination: View, Label: View>: View {

    private let icon: SettingIcon?

    private let label: Label

    private let color: Color?

    private let destination: () -> Destination

    public var body: some View {
        NavigationLink(destination: destination()) {
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
        .buttonStyle(.plain)
    }
    
    public init(
        label: Label,
        color: Color? = nil,
        icon: SettingIcon? = nil,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.label = label
        self.color = color
        self.icon = icon
        self.destination = destination
    }
}

extension PushSetting where Label == Text {

    public init(
        _ titleKey: LocalizedStringKey,
        color: Color? = nil,
        icon: SettingIcon? = nil,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.label = Text(titleKey)
            .fontWeight(icon == nil ? .semibold : .regular)
        self.color = color
        self.icon = icon
        self.destination = destination
    }
    
    public init<S: StringProtocol>(
        _ title: S,
        color: Color? = nil,
        icon: SettingIcon? = nil,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.label = Text(title)
            .fontWeight(icon == nil ? .semibold : .regular)
        self.color = color
        self.icon = icon
        self.destination = destination
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        Form {
            Section {
                PushSetting("Title") {
                    Text("Destination")
                }
                PushSetting("Title", icon: SettingIcon("shippingbox.fill")) {
                    Text("Destination")
                }
                PushSetting(label: Text("Title").fontWeight(.semibold)) {
                    Text("Destination")
                }
            }
        }.navigationTitle("Settings")
    }
}
