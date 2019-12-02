//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct SwitchSetting: View {

    private let title: String
    
    @Binding private var isOn: Bool
    
    public var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
        }
    }
    
    public init(title: String = "", isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
    }
}
