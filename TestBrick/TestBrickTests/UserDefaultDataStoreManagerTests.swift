//
//  UserDefaultDataStoreManagerTests.swift
//  TestBrickTests
//
//  Created by Habibur Rahman on 1/5/25.
//

import XCTest
@testable import TestBrick // Replace with your actual module name

final class UserDefaultDataStoreManagerTests: XCTestCase {

    // Test Keys
    private let stringKey = "test_string"
    private let intKey = "test_int"
    private let boolKey = "test_bool"
    private let codableKey = "test_profile"

    struct Profile: Codable, Equatable {
        let name: String
        let age: Int
    }

    override func setUpWithError() throws {
        // Clean up before each test
        removeTestKeys()
    }

    override func tearDownWithError() throws {
        // Clean up after each test
        removeTestKeys()
    }

    func removeTestKeys() {
        let manager = UserDefaultDataStoreManager.shared
        [stringKey, intKey, boolKey, codableKey].forEach {
            manager.remove(forKey: $0)
        }
    }

    // MARK: - Primitive Type Tests

    func testStoreAndRetrieveString() {
        let manager = UserDefaultDataStoreManager.shared
        manager.set("TestUser", forKey: stringKey)
        let value = manager.get(forKey: stringKey, as: String.self)
        XCTAssertEqual(value, "TestUser")
    }

    func testStoreAndRetrieveInt() {
        let manager = UserDefaultDataStoreManager.shared
        manager.set(42, forKey: intKey)
        let value = manager.get(forKey: intKey, as: Int.self)
        XCTAssertEqual(value, 42)
    }

    func testStoreAndRetrieveBool() {
        let manager = UserDefaultDataStoreManager.shared
        manager.set(true, forKey: boolKey)
        let value = manager.get(forKey: boolKey, as: Bool.self)
        XCTAssertTrue(value ?? false)
    }

    // MARK: - Codable Type Test

    func testStoreAndRetrieveCodableObject() {
        let manager = UserDefaultDataStoreManager.shared
        let profile = Profile(name: "Alice", age: 25)
        manager.set(profile, forKey: codableKey)
        let retrieved = manager.get(forKey: codableKey, as: Profile.self)
        XCTAssertEqual(profile, retrieved)
    }

    // MARK: - Existence & Removal

    func testExistsAndRemove() {
        let manager = UserDefaultDataStoreManager.shared
        manager.set("hello", forKey: stringKey)
        XCTAssertTrue(manager.exists(key: stringKey))

        manager.remove(forKey: stringKey)
        XCTAssertFalse(manager.exists(key: stringKey))
    }

    func testClearAll() {
        let manager = UserDefaultDataStoreManager.shared
        manager.set("test", forKey: stringKey)
        manager.set(true, forKey: boolKey)

        manager.clearAll()

        XCTAssertNil(manager.get(forKey: stringKey, as: String.self))
        XCTAssertNil(manager.get(forKey: boolKey, as: Bool.self))
    }
}
