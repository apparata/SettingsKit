//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct TitleValueSetting: View {

    private let title: String
    
    private let value: String

    public var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
    }
    
    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}