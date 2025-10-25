//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

public struct SettingIcon: View {

    let icon: Image

    @Environment(\.settingIconStyle) private var style

    public var body: some View {
        ZStack {
            style.color
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            icon
                .imageScale(.small)
                .foregroundColor(style.titleColor)
        }
        .frame(width: 24, height: 24)
    }

    public init(_ systemIcon: String) {
        self.icon = Image(systemName: systemIcon)
    }

    public init(name: String) {
        self.icon = Image(name)
    }
}

// MARK: Style Modifier

extension View {

    public func settingIconStyle(color: Color = .accentColor, titleColor: Color = .white) -> some View {
        let style = SettingIconStyle(color: color, titleColor: titleColor)
        return self.environment(\.settingIconStyle, style)
    }

    public func settingIconStyle(_ style: SettingIconStyle) -> some View {
        return self.environment(\.settingIconStyle, style)
    }
}

// MARK: - SettingIconStyle

public struct SettingIconStyle: Sendable, Hashable {
    public let color: Color
    public let titleColor: Color

    public init(color: Color, titleColor: Color) {
        self.color = color
        self.titleColor = titleColor
    }
}

struct SettingIconStyleKey: EnvironmentKey {
    static let defaultValue = SettingIconStyle(
        color: .accentColor,
        titleColor: .white
    )
}

extension EnvironmentValues {
    var settingIconStyle: SettingIconStyle {
        get {
            return self[SettingIconStyleKey.self]
        }
        set {
            self[SettingIconStyleKey.self] = newValue
        }
    }
}

// MARK: - Preview

struct SettingsRowIcon_Previews: PreviewProvider {
    static var previews: some View {
        SettingIcon("square.fill.text.grid.1x2")
            .settingIconStyle(color: .green)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Example")
        SettingIcon("circle")
            .settingIconStyle(color: .blue)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Example")
        SettingIcon("ant")
            .settingIconStyle(color: .orange)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Example")
    }
}
