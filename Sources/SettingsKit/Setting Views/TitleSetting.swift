//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

public struct TitleSetting: View {

    private let title: String

    public var body: some View {
        Text(title)
    }
    
    public init(_ title: String) {
        self.title = title
    }
}
