
# SettingsKit

## License

See the LICENSE file for licensing information.

## User Defaults

### `ObservableUserDefaults`

 Base class for observable settings objects.

```Swift
public class Settings: ObservableUserDefaults {
     
    @UserDefault("isOnboardingEnabledSetting", default: true)
    public var isOnboardingEnabled: Bool
     
    @UserDefault("apiEnvironmentSetting", default: .development)
    public var apiEnvironment: APIEnvironment

    @UserDefault("isDebugLogEnabledSetting", default: false)
    public var isDebugLogEnabled: Bool
     
    @UserDefault("DebugLogFilename", default: "log.txt")
    public var logFilename: String
}
```

Subscribing to UserDefaults changes:

```Swift
private func subscribeToAPIEnvironmentChanges() {
    settings.$apiEnvironment.sink { [weak self] environment in
        self?.didRequestAPIEnvironmentChange(to: environment)
    }.store(in: &cancellables)
}
```

### `@UserDefault`

Example of using the `@UserDefault` property wrapper.

```Swift
class SomeClass {
    @UserDefault("THE_KEY", default: 8)
    var whatever: Int
```

## Form Row Views

### `BoundButtonSetting`

```Swift
@State private var buttonTitle: String = "On"

BoundButtonSetting($buttonTitle) {
    self.buttonTitle = "Off"
}
```

### `ButtonSetting`

```Swift
ButtonSetting("OK") {
    print("OK!")
}
```

### `DestructiveButtonSetting`

Red button for destructive actions.

```Swift
DestructiveButtonSetting("Delete") {
    print("Destroy!")
}
```

### `EnumPickerSetting`

Setting view for picking an enum value.
 
The enum should be `CaseIterable`, `Codable`, `Identifiable`, and `CustomStringConvertible`.
 
*Example:*
 
```Swift
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

@State private var selectedAPIEnvironment: APIEnvironment

EnumPickerSetting(title: "API Environment", selected: $selectedAPIEnvironment)
```

### `EnumSegmentedPickerSetting`

```Swift
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

@State private var selectedAPIEnvironment: APIEnvironment

EnumSegmentedPickerSetting(selected: $selectedAPIEnvironment)
```

### `SegmentedPickerSetting`

A segmented setting view for picking a value from a collection.

*Example:*

```Swift
SegmentedPickerSetting(title: "API Environment",
                       values: APIEnvironment.allCases,
                       selected: $settings.apiEnvironment)
```

### `SwiftSetting`

```Swift
@State private var isLogEnabled: Bool

SwitchSetting(title: "Enable log", isOn: $isLogEnabled)
```

### `TitleEditableTextSetting`

Title and text field setting.

*Example:*

```Swift
TitleEditableTextSetting(title: "Log Filename",
                         value: $settings.logFilename)
```

### `TitleSetting`

```Swift
TitleSetting(title: "Name")
```

### `TitleValueSetting`

```Swift
TitleValueSetting(title: "Name", value: "Steve")
```

### `ValuePickerSetting`

A setting view for picking a value from a collection.

```Swift
ValuePickerSetting(title: "API Environment",
                   values: APIEnvironment.allCases,
                   selected: $settings.apiEnvironment)
```
