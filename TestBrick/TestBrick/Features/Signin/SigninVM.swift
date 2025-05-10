//
//  SigninVM.swift
//  TestBrick
//
//  Created by Habibur Rahman on 1/5/25.
//

import Foundation

class SigninVM: ObservableObject {
    @Published var email: String = ""
    @Published var goToWelcomeView: Bool = false
    @Published var isLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var alertMessage: String = ""

    private let profileManager = UserProfileManager.shared
    let firebaseManager = FirestoreUserManager()

    func onSigninButtonPressed() {
        if email.isEmpty {
            showErrorAlert = true
            alertMessage = "Please insert email address."
            return
        }

        isLoading = true
        let profile = UserProfileData(email: email)

        firebaseManager.saveUserProfile(profile) { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    print("Error saving profile:", error)
                    self?.showErrorAlert = true
                    self?.alertMessage = error.localizedDescription
                } else {
                    self?.profileManager.save(profile: profile)
                    print("Profile saved successfully.")
                    self?.goToWelcomeView = true
                }
            }
        }
    }
}
