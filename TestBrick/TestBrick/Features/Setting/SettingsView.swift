//
//  SettingsView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 8/5/25.
//

import Firebase
import SwiftUI

struct SettingsView: View {
  
    @State private var showAlert = false
    @State private var showLoading = false
    @State private var deletionErrorMessage: String?

    let firebaseManager = FirestoreUserManager()
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

            if showLoading {
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.8)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert"),
                message: Text(deletionErrorMessage ?? "Unknown Error"),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func deleteUserData() {
        guard let userEmail = profileManager.fetch()?.email else {
            deletionErrorMessage = "Could not find user email."
            return
        }

        showLoading = true

        firebaseManager.deleteUserProfile(email: userEmail) { error in
            DispatchQueue.main.async {
                showLoading = false
                if let error = error {
                    deletionErrorMessage = error.localizedDescription
                } else {
                    profileManager.logout()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
