//
//  Copyright © 2021 Apparata AB. All rights reserved.
//

import SwiftUI

// MARK: - DestructiveButtonSetting

public struct DestructiveButtonSetting<Label: View>: View {
    
    let label: Label
    
    let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            label
                .frame(maxWidth: .infinity)
                .foregroundColor(.red)
        }
    }
    
    public init(label: Label, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
}

extension DestructiveButtonSetting where Label == Text {
    
    public init(_ titleKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.label = Text(titleKey)
            .fontWeight(.semibold)
        self.action = action
    }
    
    public init<S: StringProtocol>(_ title: S, action: @escaping () -> Void) {
        self.label = Text(title)
            .fontWeight(.semibold)
        self.action = action
    }
}

// MARK: - Preview

struct DestructiveButtonSetting_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                Section {
                    DestructiveButtonSetting("Title") {
                        print("Hello")
                    }
                }
            }.navigationTitle("Settings")
        }
    }
}
