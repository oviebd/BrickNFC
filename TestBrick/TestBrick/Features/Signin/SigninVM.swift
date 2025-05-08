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
       
    private let profileManager = UserProfileManager.shared
    let firebaseManager = FirestoreUserManager()
    
    
    func onSigninButtonPressed(){
        
        let profile = UserProfileData(email: email)
        
        firebaseManager.saveUserProfile(profile) { [weak self] error in
            if let error = error {
                print("Error saving profile:", error)
            } else {
                self?.profileManager.save(profile: profile)
                print("Profile saved successfully.")
            }
        }
        
    }
}
