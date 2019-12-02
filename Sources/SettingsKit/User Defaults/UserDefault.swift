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
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return defaultValue
            }
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                return defaultValue
            }
            return value
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Error: Failed to store user default value for key '\(key)'")
                UserDefaults.standard.removeObject(forKey: key)
                return
            }
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    public var projectedValue: AnyPublisher<T, Never> {
        userDefaultObserver.publisher
            .map { self.wrappedValue }
            .eraseToAnyPublisher()
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
