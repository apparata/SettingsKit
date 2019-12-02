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

    private let title: String
    
    private let values: [T]

    @Binding private var selected: T

    public var body: some View {
        Picker(selection: $selected, label: Text(title)) {
            ForEach(values) { value in
                Text(value.description).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    public init(title: String = "", values: [T], selected: Binding<T>) {
        self.title = title
        self.values = values
        self._selected = selected
    }
}
