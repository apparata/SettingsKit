
# SettingsKit

## License

See the LICENSE file for licensing information.

## User Defaults

### `ObservableUserDefaults`

 Base class for observable settings objects. **NOTE:** There must not be dots in the key, or the kvo observation does not work, for some reason.

**Example:**

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

Example of using the `@UserDefault` property wrapper. If you have `@AppStorage` properties in your SwiftUI views, the same keys can be used with `@UserDefault` to access the same values.

**Example:**

```Swift
class SomeClass {
    @UserDefault("THE_KEY", default: 8)
    var whatever: Int
```

## Form Row Views

### `ButtonSetting`

**Example:**

```Swift
ButtonSetting("OK") {
    print("OK!")
}
```

### `DestructiveButtonSetting`

Red button for destructive actions.

**Example:**

```Swift
DestructiveButtonSetting("Delete") {
    print("Destroy!")
}
```

### `LinkSetting`

**Example:**

```Swift
LinkSetting("Github", url: URL(string: "https://github.com")!) {
    print("OK!")
}
```

### `EnumSetting`

Setting view for picking an enum value.
 
The enum should be `CaseIterable` and `Pickable`, which is a typealias for the combination of `Codable`, `Identifiable`, and `CustomStringConvertible`.
 
**Example:**
 
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

@State private var apiEnvironment: APIEnvironment

EnumSetting("API Environment", selection: $apiEnvironment)
```

### `SegmentedEnumSetting`

The enum should be `CaseIterable` and `Pickable`, which is a typealias for the combination of `Codable`, `Identifiable`, and `CustomStringConvertible`.

**Example:**

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

@State private var apiEnvironment: APIEnvironment

SegmentedEnumSetting(selection: $apiEnvironment)
```

### `SegmentedSetting`

A segmented setting view for picking a value from a collection.

**Example:**

```Swift
SegmentedSetting("API Environment",
                 values: APIEnvironment.allCases,
                 selection: $settings.apiEnvironment)
```

### `SwitchSetting`

**Example:**

```Swift
@State private var isLogEnabled: Bool

SwitchSetting("Enable log", isOn: $isLogEnabled)
```

### `TextFieldTextSetting`

Title and text field setting.

**Example:**

```Swift
TextFieldSetting("Log Filename",
                 value: $settings.logFilename)
```

### `LabelSetting`

**Example:**

```Swift
LabelSetting("Name")
```

```Swift
LabelSetting("Name", value: "Steve")
```

### `PickerSetting`

A setting view for picking a value from a collection.

**Example:**

```Swift
PickerSetting("API Environment",
              values: APIEnvironment.allCases,
              selection: $settings.apiEnvironment)
```
