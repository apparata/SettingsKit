//
//  Copyright © 2019 Apparata AB. All rights reserved.
//

#if canImport(Security)

import Foundation
import Security

/// Example:
///
/// ```
/// @KeychainItem("THE_TOKEN")
/// var someImportantToken: String
///
/// @KeychainItem("THE_OTHER_TOKEN", service: "com.whatever.tokens")
/// var someOtherToken: String
/// ```
@propertyWrapper
public struct KeychainItem<Value: Codable> {
    
    private let account: String
    private let service: String?
            
    public var wrappedValue: Value? {
        get {
            copyItem(account: account)
        }
        set {
            if let newValue = newValue {
                if isExistingItem {
                    updateItem(account: account, value: newValue)
                } else {
                    addItem(account: account, value: newValue)
                }
            } else {
                deleteItem(account: account)
            }
        }
    }
    
    private var isExistingItem: Bool {
        return copyItem(account: account) != nil
    }
    
    public init(_ account: String, service: String? = nil) {
        self.account = account
        self.service = service
    }
    
    private func copyItem(account: String) -> Value? {
        var query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: true as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        if let service = service {
            query[kSecAttrService as String] = service as AnyObject
        }
        var result: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if status == errSecItemNotFound {
            return nil
        }
        guard status == 0 else {
            print("[KeychainItem] Copy Error: \(status)")
            return nil
        }
        guard let data = result as? Data else {
            print("[KeychainItem] Copy Error: Invalid Data")
            return nil
        }
        do {
            let value = try JSONDecoder().decode(Value.self, from: data)
            return value
        } catch {
            print("[KeychainItem] Copy Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func updateItem(account: String, value: Value) {
        guard let data = try? JSONEncoder().encode(value) else {
            print("[KeychainItem] Add Error: Could not encode value.")
            return
        }
        var query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject
        ]
        if let service = service {
            query[kSecAttrService as String] = service as AnyObject
        }
        let attributes: [String: AnyObject] = [
            kSecValueData as String: data as AnyObject
        ]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status == 0 else {
            print("[KeychainItem] Add Error: \(status)")
            return
        }
    }
    
    private func addItem(account: String, value: Value) {
        guard let data = try? JSONEncoder().encode(value) else {
            print("[KeychainItem] Add Error: Could not encode value.")
            return
        }
        var query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: data as AnyObject
        ]
        if let service = service {
            query[kSecAttrService as String] = service as AnyObject
        }
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == 0 else {
            print("[KeychainItem] Add Error: \(status)")
            return
        }
    }
    
    private func deleteItem(account: String) {
        var query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject
        ]
        if let service = service {
            query[kSecAttrService as String] = service as AnyObject
        }
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecItemNotFound {
            return
        }
        guard status == 0 else {
            print("[KeychainItem] Delete Error: \(status)")
            return
        }
    }
    
}

#endif
