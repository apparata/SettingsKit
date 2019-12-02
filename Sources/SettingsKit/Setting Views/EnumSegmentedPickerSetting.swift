//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import SwiftUI
import Combine

/**
 Segmented setting view for picking an enum value.
 
 The enum should be `CaseIterable`, `Codable`, `Identifiable`,
 and `CustomStringConvertible`.
 
 *Example:*
 
 ```
 public enum APIEnvironment: String, CaseIterable, Codable, Identifiable {
     case development = "Development"
     case staging = "Staging"
     case production = "Production"
 }

 extension APIEnvironment: CustomStringConvertible {
     public var description: String {
         rawValue
     }
     
     public var id: APIEnvironment { self }
 }
 ```
 */
public struct EnumSegmentedPickerSetting<T: CaseIterable & CustomStringConvertible & Hashable & Identifiable>: View {

    private let title: String
    
    @Binding private var selected: T

    public var body: some View {
        Picker(selection: $selected, label: Text(title)) {
            ForEach(Array(T.allCases)) { value in
                Text(value.description).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    public init(title: String = "", selected: Binding<T>) {
        self.title = title
        self._selected = selected
    }
}
