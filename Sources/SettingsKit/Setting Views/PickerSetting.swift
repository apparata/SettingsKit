//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - PickerSetting

/// A setting view for picking a value from a collection.
///
/// Values must conform to `Pickable`.
///
/// *Example:*
///
/// ```
/// PickerSetting("API Environment",
///               values: APIEnvironment.allCases,
///               selection: $settings.apiEnvironment)
/// ```
public struct PickerSetting<Label: View, T: Pickable>: View {
    
    let icon: SettingIcon?

    let label: Label
    
    let values: [T]

    @Binding var selection: T
    
    public var body: some View {
        Picker(selection: $selection, label: HStack {
                icon
                label
                Spacer()
            }) {
            ForEach(values) { value in
                Text(value.description).tag(value)
            }
        }
    }
    
    public init(label: Label, values: [T], selection: Binding<T>, icon: SettingIcon? = nil) {
        self.label = label
        self.values = values
        self._selection = selection
        self.icon = icon
    }
}

extension PickerSetting where Label == Text {

    public init(_ titleKey: LocalizedStringKey, values: [T], selection: Binding<T>, icon: SettingIcon? = nil) {
        self.label = Text(titleKey)
        self.values = values
        self._selection = selection
        self.icon = icon
    }
    
    public init<S: StringProtocol>(_ title: S, values: [T], selection: Binding<T>, icon: SettingIcon? = nil) {
        self.label = Text(title)
        self.values = values
        self._selection = selection
        self.icon = icon
    }
}

// MARK: - Preview

struct PickerSetting_Previews: PreviewProvider {
    
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
                    PickerSetting(
                        "Title",
                        values: APIEnvironment.allCases,
                        selection: .constant(.development)
                    )
                    PickerSetting(
                        "Title",
                        values: APIEnvironment.allCases,
                        selection: .constant(.development),
                        icon: SettingIcon("4k.tv.fill")
                    )
                    PickerSetting(
                        "Title",
                        values: APIEnvironment.allCases,
                        selection: .constant(.development),
                        icon: SettingIcon("4k.tv")
                    )
                }
            }.navigationTitle("Settings")
        }
    }
}
