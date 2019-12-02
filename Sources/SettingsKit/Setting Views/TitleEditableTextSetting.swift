//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

/// Title and text field setting.
///
/// *Example:*
///
/// ```
/// TitleEditableTextSetting(title: "Log Filename",
///                          value: $settings.logFilename)
/// ```
struct TitleEditableTextSetting: View {

    public let title: String
    
    @Binding public var value: String

    public var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField("", text: $value)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.secondary)
                .frame(maxWidth: 100)
        }
    }
}

