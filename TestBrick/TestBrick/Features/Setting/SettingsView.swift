//
//  SettingsView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 8/5/25.
//

import Firebase
import SwiftUI

import Firebase
import SwiftUI

struct SettingsView: View {
   
    @State private var showAlert = false
    @State private var deletionSuccess = false
    @State private var deletionError: String?

    let firebaseManager = FirestoreUserManager()
   
    //  @AppStorage(AppConstants.UserDefaultsKeys.isLoggedIn) private var isLoggedIn: Bool = true

    let profileManager = UserProfileManager.shared

    var body: some View {
        ZStack {
            Color(.darkGray)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Button(action: {
                    showAlert = true
                }) {
                    Text("Delete My Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 50)
                        .background(Color.red)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .alert("Are you sure?", isPresented: $showAlert) {
                    Button("Delete", role: .destructive, action: deleteUserData)
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("This will permanently delete all your data.")
                }
            }
        }

    }

    func deleteUserData() {
        guard let userEmail = profileManager.fetch()?.email else {
            return
        }

        firebaseManager.deleteUserProfile(email: userEmail) { error in
            if let error = error {
                deletionError = error.localizedDescription
                deletionSuccess = false

            } else {
                deletionSuccess = true
                deletionError = nil
                profileManager.logout()
               
            }
        }
    }
}

#Preview {
    SettingsView()
}
