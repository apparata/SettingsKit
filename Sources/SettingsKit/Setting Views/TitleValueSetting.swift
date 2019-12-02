//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct TitleValueSetting: View {

    public let title: String
    
    public let value: String

    public var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
    }
}
