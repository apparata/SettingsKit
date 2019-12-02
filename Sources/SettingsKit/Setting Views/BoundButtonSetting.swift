//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct BoundButtonSetting: View {

    @Binding private var title: String

    private var action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
    }
    
    public init(_ title: Binding<String>, action: @escaping () -> Void) {
        self._title = title
        self.action = action
    }
}
