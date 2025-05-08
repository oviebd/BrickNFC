//
//  ProfileManager.swift
//  TestBrick
//
//  Created by Habibur Rahman on 1/5/25.
//

import Foundation

final class UserProfileManager {

    static let shared = UserProfileManager()
    private let key = AppConstants.UserDefaultsKeys.userProfileInfo
    private let store = UserDefaultDataStoreManager.shared

    private init() {}

    // MARK: - Save

    func save(profile: UserProfileData) {
        store.set(profile, forKey: key)
        store.set(true, forKey: AppConstants.UserDefaultsKeys.isLoggedIn)
    }

    // MARK: - Fetch

    func fetch() -> UserProfileData? {
        return store.get(forKey: key, as: UserProfileData.self)
    }

    // MARK: - Login State

    var isLoggedIn: Bool {
        guard let profile = fetch() else { return false }
        return !profile.email.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - Remove

    func logout() {
        store.remove(forKey: key)
        store.set(false, forKey: AppConstants.UserDefaultsKeys.isLoggedIn)
    }

    func exists() -> Bool {
        return store.exists(key: key)
    }
}
