//
//  KeychainManager.swift
//  AppPapple
//
//  Created by Christian Morante on 14/01/25.
//

import Security
import Foundation

class KeychainManager {
    static let shared = KeychainManager()

    private init() {}

    func save(key: String, value: String) -> Bool {
        let data = value.data(using: .utf8)!

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary) // Elimina si ya existe
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }

    func read(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == errSecSuccess {
            if let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }

    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}

// Ejemplo de uso:
//let keychain = KeychainManager.shared
//keychain.save(key: "userToken", value: "abcdef12345")
//if let token = keychain.read(key: "userToken") {
//    print("Token recuperado: \(token)")
//}
//keychain.delete(key: "userToken")
