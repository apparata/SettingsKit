//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct ButtonSetting: View {

    public var title: String
    
    public var action: () -> Void
    
    public var body: some View {
        Button(title) {
            self.action()
        }
    }
}
