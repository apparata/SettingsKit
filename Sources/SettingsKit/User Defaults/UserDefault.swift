//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

import Foundation
import Combine

/// Example:
///
/// ```
/// @UserDefault("THE_KEY", default: 8)
/// var whatever: Int
/// ```
@propertyWrapper
public class UserDefault<T: Codable> {
    
    public let key: String
    
    public let defaultValue: T
    
    public var wrappedValue: T {
        get {
            if isBasicType {
                return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
            } else {
                guard let data = UserDefaults.standard.data(forKey: key) else {
                    return defaultValue
                }
                guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                    return defaultValue
                }
                return value
            }
        }
        set {
            if isBasicType {
                UserDefaults.standard.set(newValue, forKey: key)
            } else {
                guard let data = try? JSONEncoder().encode(newValue) else {
                    print("Error: Failed to store user default value for key '\(key)'")
                    UserDefaults.standard.removeObject(forKey: key)
                    return
                }
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
    
    public var projectedValue: AnyPublisher<T, Never> {
        userDefaultObserver.publisher
            .map { self.wrappedValue }
            .eraseToAnyPublisher()
    }
    
    private var isBasicType: Bool {
        T.self == Bool.self
            || T.self == Float.self
            || T.self == Double.self
            || T.self == Int.self
            || T.self == Int32.self
            || T.self == Int16.self
            || T.self == String.self
            || T.self == URL.self
            || T.self == Date.self
            || T.self == Data.self
    }
    
    private let userDefaultObserver: UserDefaultObserver
    
    public init(_ key: String, `default` defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        userDefaultObserver = UserDefaultObserver(key: key)
    }
    
}

fileprivate class UserDefaultObserver: NSObject {
    
    private var kvoContext = 0 // Arbitrary value, does not matter
    
    private let key: String
    
    private let subject = PassthroughSubject<(), Never>()
    
    var publisher: AnyPublisher<(), Never> {
        subject.eraseToAnyPublisher()
    }
    
    init(key: String) {
        self.key = key
        super.init()
        startObserving()
    }
    
    deinit {
        stopObserving()
    }
    
    private func startObserving() {
        UserDefaults.standard.addObserver(self, forKeyPath: key, options: [.new], context: &kvoContext)
    }
    
    private func stopObserving() {
        UserDefaults.standard.removeObserver(self, forKeyPath: key, context: &kvoContext)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &kvoContext {
            subject.send(())
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
