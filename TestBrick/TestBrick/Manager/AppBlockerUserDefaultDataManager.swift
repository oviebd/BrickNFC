//
//  AppBlockerUserDefaultDataManager.swift
//  TestBrick
//
//  Created by Habibur Rahman on 1/5/25.
//

import Foundation

final class AppBlockerUserDefaultDataManager {

    static let shared = AppBlockerUserDefaultDataManager()

    private let store = UserDefaultDataStoreManager.shared
    private let isBlockingKey = AppConstants.UserDefaultsKeys.isBlocking

    private init() {}

    func setBlockingEnabled(_ enabled: Bool) {
        store.set(enabled, forKey: isBlockingKey)
    }

    func isBlockingEnabled() -> Bool {
        return store.get(forKey: isBlockingKey, as: Bool.self) ?? false
    }

//    func removeBlockingStatus() {
//        store.remove(forKey: isBlockingKey)
//    }
}
