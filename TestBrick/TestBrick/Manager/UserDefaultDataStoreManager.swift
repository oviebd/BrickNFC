//
//  UserDefaultDataStoreManager.swift
//  TestBrick
//
//  Created by Habibur Rahman on 1/5/25.
//

import Foundation

final class UserDefaultDataStoreManager {

    static let shared = UserDefaultDataStoreManager()
    private let userDefaults = UserDefaults.standard

    private init() {}

    // MARK: - Set

    func set<T: Codable>(_ value: T, forKey key: String) {
        if isPrimitive(value) {
            userDefaults.set(value, forKey: key)
        } else {
            do {
                let encoded = try JSONEncoder().encode(value)
                userDefaults.set(encoded, forKey: key)
            } catch {
                print("Failed to encode value for key '\(key)': \(error)")
            }
        }
    }

    // MARK: - Get

    func get<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        if isPrimitiveType(type) {
            return userDefaults.object(forKey: key) as? T
        } else if let data = userDefaults.data(forKey: key) {
            return try? JSONDecoder().decode(T.self, from: data)
        } else {
            return nil
        }
    }

    // MARK: - Remove

    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func exists(key: String) -> Bool {
        userDefaults.object(forKey: key) != nil
    }

    func clearAll() {
        for (key, _) in userDefaults.dictionaryRepresentation() {
            userDefaults.removeObject(forKey: key)
        }
    }

    // MARK: - Helpers

    private func isPrimitive<T: Codable>(_ value: T) -> Bool {
        switch value {
        case is String, is Int, is Bool, is Double, is Float, is Data:
            return true
        default:
            return false
        }
    }

    private func isPrimitiveType<T: Codable>(_ type: T.Type) -> Bool {
        switch type {
        case is String.Type, is Int.Type, is Bool.Type, is Double.Type, is Float.Type, is Data.Type:
            return true
        default:
            return false
        }
    }
}
