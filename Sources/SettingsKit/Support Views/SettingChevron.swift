//
//  Copyright © 2023 Apparata AB. All rights reserved.
//

import SwiftUI

public struct SettingChevron: View {

    public init() {
        //
    }

    public var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 14.0, weight: .semibold))
            .foregroundColor(.secondary)
            .opacity(0.5)
    }
}

#Preview {
    Form {
        HStack {
            Spacer()
            SettingChevron()
        }
    }
    #if os(macOS)
    .formStyle(.grouped)
    #endif
}
