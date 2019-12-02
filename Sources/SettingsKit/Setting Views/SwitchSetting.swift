//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct SwitchSetting: View {

    public let title: String
    
    @Binding public var isOn: Bool
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
        }
    }
}
