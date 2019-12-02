//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import Foundation
import Combine

/**
 Base class for observable settings objects.
 
 *Example:*
 
 ```
 public class Settings: ObservableUserDefaults {
     
     @UserDefault("isOnboardingEnabledSetting", default: true)
     public var isOnboardingEnabled: Bool
     
     @UserDefault("apiEnvironmentSetting", default: .development)
     public var apiEnvironment: APIEnvironment

     @UserDefault("isDebugLogEnabledSetting", default: false)
     public var isDebugLogEnabled: Bool
     
     @UserDefault("EngineeringModeLogFilename", default: "log.txt")
     public var logFilename: String
 }
 ```
 
 *Example:*
 
 ```
 private func subscribeToAPIEnvironmentChanges() {
     settings.$apiEnvironment.sink { [weak self] environment in
         self?.didRequestAPIEnvironmentChange(to: environment)
     }.store(in: &cancellables)
 }
 ```
 */
open class ObservableUserDefaults: ObservableObject {
    
    public let objectWillChange = PassthroughSubject<Void, Never>()
    
    private var didChangeCancellable: AnyCancellable?
    
    public init() {
        didChangeCancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .receive(on: DispatchQueue.main)
            .subscribe(objectWillChange)
    }
}
