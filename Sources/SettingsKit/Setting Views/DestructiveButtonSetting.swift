//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct DestructiveButtonSetting: View {

    private var title: String
    
    private var action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .foregroundColor(.red)
        }
    }
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}
