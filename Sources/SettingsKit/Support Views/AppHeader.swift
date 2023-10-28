//
//  Copyright © 2020 Apparata AB. All rights reserved.
//

import SwiftUI

public struct AppHeader: View {
    
    let name: String
    let version: String
    let icon: String?
    let iconSize: CGFloat
    let title: Text
        
    public var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                imageOrPlaceholder
                    .frame(width: iconSize, height: iconSize)
                    .clipShape(RoundedRectangle(cornerRadius: iconSize / 5.7, style: .continuous))
                    .padding(.bottom)

                HStack(spacing: 6) {
                    Text(name)
                        .fontWeight(.semibold)
                        .textCase(.none)
                        .font(.title2)
                        .foregroundColor(.primary)
                    Text(version)
                        .fontWeight(.regular)
                        .textCase(.none)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .padding([.horizontal, .bottom])
            .padding(.top, 4)
            HStack {
                title
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder private var imageOrPlaceholder: some View {
        if let icon = icon {
            Image(icon)
                .resizable()
        } else {
            Rectangle()
                .foregroundColor(.blue)
                .overlay(Text("\(Int(iconSize)) x \(Int(iconSize))").foregroundColor(.white))
        }
    }

    public init(name: String, version: String, icon: String?, iconSize: CGFloat = 120, titleKey: LocalizedStringKey) {
        self.name = name
        self.version = version
        self.icon = icon
        self.iconSize = iconSize
        self.title = Text(titleKey)
    }
    
    public init<S: StringProtocol>(name: String, version: String, icon: String?, iconSize: CGFloat = 120, title: S) {
        self.name = name
        self.version = version
        self.icon = icon
        self.iconSize = iconSize
        self.title = Text(title)
    }
}

struct AppHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                Section(header: AppHeader(name: "Placeholder", version: "1.0.0", icon: nil, title: "General")) {
                    LabelSetting("Title")
                    LabelSetting("Title", icon: SettingIcon("shippingbox.fill"))
                    LabelSetting("Title", icon: SettingIcon("crown.fill"))
                    NavigationLink(destination: Text("")) {
                        LabelSetting("Title")
                    }
                    NavigationLink(destination: Text("")) {
                        LabelSetting("Title", icon: SettingIcon("mosaic.fill"))
                    }
                }
            }.navigationTitle("Settings")
        }
    }
}
