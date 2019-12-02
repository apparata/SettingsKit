//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct BoundTitleValueSetting: View {

    private let title: String
    
    @Binding private var value: String

    public var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
    }
    
    public init(title: String, value: Binding<String>) {
        self.title = title
        self._value = value
    }
}
