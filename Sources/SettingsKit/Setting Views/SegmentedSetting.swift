//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - SegmentedSetting

/// A segmented setting view for picking a value from a collection.
///
/// *Example:*
///
/// ```
/// SegmentedSetting("API Environment",
///                  values: APIEnvironment.allCases,
///                  selection: $apiEnvironment)
/// ```
public struct SegmentedSetting<Label: View, T: Pickable>: View {
    
    let label: Label
    
    let values: [T]

    @Binding var selection: T

    public var body: some View {
        Picker(selection: $selection, label: label) {
            ForEach(values) { value in
                Text(value.description).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    public init(label: Label, values: [T], selection: Binding<T>) {
        self.label = label
        self.values = values
        self._selection = selection
    }
}

extension SegmentedSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, values: [T], selection: Binding<T>) {
        self.label = Text(titleKey)
        self.values = values
        self._selection = selection
    }
    
    public init<S: StringProtocol>(_ title: S, values: [T], selection: Binding<T>) {
        self.label = Text(title)
        self.values = values
        self._selection = selection
    }
}

// MARK: - Preview

struct SegmentedSetting_Previews: PreviewProvider {
    
    enum APIEnvironment: String, Pickable, CaseIterable {
        case development = "Development"
        case staging = "Staging"
        case production = "Production"
        
        var id: APIEnvironment { self }
        var description: String {
            rawValue
        }
    }
    
    static var previews: some View {
        NavigationView {
            Form {
                Section {
                    SegmentedSetting("Title",
                                     values: APIEnvironment.allCases,
                                     selection: .constant(.development))
                    SegmentedSetting("Title",
                                     values: APIEnvironment.allCases,
                                     selection: .constant(.staging))
                }
            }.navigationTitle("Settings")
        }
    }
}
