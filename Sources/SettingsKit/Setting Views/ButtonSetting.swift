//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct ButtonSetting: View {

    private var title: String
    
    private var action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
    }
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}