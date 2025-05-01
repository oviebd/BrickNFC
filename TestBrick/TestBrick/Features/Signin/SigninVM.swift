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
    
    func onSigninButtonPressed(){
        
        let profile = UserProfileData(email: email)
        profileManager.save(profile: profile)
        goToWelcomeView = true
        
    }
}
