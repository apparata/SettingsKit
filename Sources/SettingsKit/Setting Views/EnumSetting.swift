//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - EnumSetting

/// Setting view for picking an enum value.
///
/// The enum should be `Pickable` and `CaseIterable`.
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
/// ```
public struct EnumSetting<Label: View, T: Pickable & CaseIterable>: View {

    let icon: SettingIcon?
    
    let label: Label
    
    @Binding var selection: T

    public var body: some View {
        Picker(selection: $selection, label: HStack {
            icon
            label
        }) {
            ForEach(Array(T.allCases)) { value in
                Text(value.description).tag(value)
            }
        }
    }
    
    public init(label: Label, selection: Binding<T>, icon: SettingIcon? = nil) {
        self.label = label
        self._selection = selection
        self.icon = icon
    }
}

extension EnumSetting where Label == Text {

    public init(_ titleKey: LocalizedStringKey, selection: Binding<T>, icon: SettingIcon? = nil) {
        self.label = Text(titleKey)
        self._selection = selection
        self.icon = icon
    }
    
    public init<S: StringProtocol>(_ title: S, selection: Binding<T>, icon: SettingIcon? = nil) {
        self.label = Text(title)
        self._selection = selection
        self.icon = icon
    }
}

// MARK: - Preview

struct EnumSetting_Previews: PreviewProvider {
    
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
                    EnumSetting(
                        "Title",
                        selection: .constant(APIEnvironment.development)
                    )
                    EnumSetting(
                        "Title",
                        selection: .constant(APIEnvironment.development),
                        icon: SettingIcon("doc.text.fill.viewfinder")
                    )
                    EnumSetting(
                        "Title",
                        selection: .constant(APIEnvironment.development),
                        icon: SettingIcon("person.fill.checkmark")
                    )
                }
                Section {
                    EnumSetting(
                        label: Text("Title"),
                        selection: .constant(APIEnvironment.development)
                    )
                    EnumSetting(
                        label: Text("Title"),
                        selection: .constant(APIEnvironment.development),
                        icon: SettingIcon("doc.text.fill.viewfinder")
                    )
                    EnumSetting(
                        label: Text("Title"),
                        selection: .constant(APIEnvironment.development),
                        icon: SettingIcon("person.fill.checkmark")
                    )
                }
            }.navigationTitle("Settings")
        }
    }
}
