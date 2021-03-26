//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

public struct SettingIcon: View {
        
    let icon: Image
    
    let color: Color
    
    public var body: some View {
        ZStack {
            color
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            icon
                .imageScale(.small)
                .foregroundColor(.white)
        }
        .frame(width: 24, height: 24)
    }

    public init(_ systemIcon: String, color: Color = .accentColor) {
        self.icon = Image(systemName: systemIcon)
        self.color = color
    }
    
    public init(name: String, color: Color = .accentColor) {
        self.icon = Image(name)
        self.color = color
    }
}

struct SettingsRowIcon_Previews: PreviewProvider {
    static var previews: some View {
        SettingIcon("square.fill.text.grid.1x2", color: .green)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Example")
        SettingIcon("circle", color: .blue)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Example")
        SettingIcon("ant", color: .orange)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Example")
    }
}
