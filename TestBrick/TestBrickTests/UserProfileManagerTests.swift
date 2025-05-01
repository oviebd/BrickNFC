//
//  UserProfileManagerTests.swift
//  TestBrickTests
//
//  Created by Habibur Rahman on 1/5/25.
//

import XCTest
@testable import TestBrick // Replace with your actual module name

final class UserProfileManagerTests: XCTestCase {

    private let manager = UserProfileManager.shared
    private let testProfile = UserProfileData(email: "test@example.com")

    override func setUpWithError() throws {
        manager.logout() // Ensure clean state before each test
    }

    override func tearDownWithError() throws {
        manager.logout() // Clean up after each test
    }

    func testSaveAndFetchUserProfile() {
        manager.save(profile: testProfile)

        let saved = manager.fetch()
        XCTAssertNotNil(saved)
        XCTAssertEqual(saved?.email, testProfile.email)
    }

    func testIsLoggedInWithValidProfile() {
        manager.save(profile: testProfile)
        XCTAssertTrue(manager.isLoggedIn)
    }

    func testIsLoggedInWithNoProfile() {
        XCTAssertFalse(manager.isLoggedIn)
    }

    func testIsLoggedInWithEmptyEmail() {
        manager.save(profile: UserProfileData(email: "   "))
        XCTAssertFalse(manager.isLoggedIn)
    }

    func testLogoutRemovesUserProfile() {
        manager.save(profile: testProfile)
        manager.logout()

        let profile = manager.fetch()
        XCTAssertNil(profile)
        XCTAssertFalse(manager.isLoggedIn)
    }

    func testExistsFunctionality() {
        XCTAssertFalse(manager.exists())
        manager.save(profile: testProfile)
        XCTAssertTrue(manager.exists())
        manager.logout()
        XCTAssertFalse(manager.exists())
    }
}
