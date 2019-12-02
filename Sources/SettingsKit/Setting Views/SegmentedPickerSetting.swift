//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

/// A segmented setting view for picking a value from a collection.
///
/// *Example:*
///
/// ```
/// SegmentedPickerSetting(title: "API Environment",
///                        values: APIEnvironment.allCases,
///                        selected: $settings.apiEnvironment)
/// ```
public struct SegmentedPickerSetting<T: CustomStringConvertible & Hashable & Identifiable>: View {

    public let title: String
    
    public let values: [T]

    @Binding public var selected: T

    public var body: some View {
        Picker(selection: $selected, label: Text(title)) {
            ForEach(values) { value in
                Text(value.description).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
