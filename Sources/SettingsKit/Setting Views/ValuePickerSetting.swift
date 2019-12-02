//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

/// A setting view for picking a value from a collection.
///
/// *Example:*
///
/// ```
/// ValuePickerSetting(title: "API Environment",
///                    values: APIEnvironment.allCases,
///                    selected: $settings.apiEnvironment)
/// ```
public struct ValuePickerSetting<T: CustomStringConvertible & Hashable & Identifiable>: View {

    private let title: String
    
    private let values: [T]

    @Binding private var selected: T

    public var body: some View {
        Picker(selection: $selected, label: Text(title)) {
            ForEach(values) { value in
                Text(value.description).tag(value)
            }
        }
    }
}
