//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - SegmentedEnumSetting

/// Segmented setting view for picking an enum value.
///
/// The enum should be `Pickable`.
///
/// *Example:*
///
/// ```
/// public enum APIEnvironment: String, CaseIterable {
///     case development = "Development"
///     case staging = "Staging"
///     case production = "Production"
/// }
///
/// extension APIEnvironment: Pickable {
///     public var id: APIEnvironment { self }
///     public var description: String {
///         rawValue
///     }
/// }
///
/// @State var apiEnvironment: APIEnvironment = .development
///
/// SegmentedEnumSetting("API Environment"
///                      selection: $apiEnvironment)
///
/// ```
public struct SegmentedEnumSetting<Label: View, T: Pickable & CaseIterable>: View {
    
    let label: Label
    
    @Binding var selection: T

    public var body: some View {
        Picker(selection: $selection, label: label) {
            ForEach(Array(T.allCases)) { value in
                Text(value.description).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    public init(label: Label, selection: Binding<T>) {
        self.label = label
        self._selection = selection
    }
}

extension SegmentedEnumSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, selection: Binding<T>) {
        self.label = Text(titleKey)
        self._selection = selection
    }
    
    public init<S: StringProtocol>(_ title: S, selection: Binding<T>) {
        self.label = Text(title)
        self._selection = selection
    }
}

// MARK: - Preview

struct SegmentedEnumSetting_Previews: PreviewProvider {
    
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
                    SegmentedEnumSetting(
                        "Title",
                        selection: .constant(APIEnvironment.development))
                    SegmentedEnumSetting(
                        "Title",
                        selection: .constant(APIEnvironment.staging))
                }
            }.navigationTitle("Settings")
        }
    }
}
