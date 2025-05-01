//
//  SignInView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var goToWelcomeView: Bool = false

//    init() {
//           let appearance = UINavigationBarAppearance()
//           appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.clear
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//           // Apply appearance
//           UINavigationBar.appearance().standardAppearance = appearance
//           UINavigationBar.appearance().scrollEdgeAppearance = appearance
//
//           // Set the back button (arrow) color
//           UINavigationBar.appearance().tintColor = .red
//       }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // arrowAndtitle

                description

                Spacer()

                textFieldForEmail

                signInButton
                Spacer()
            }

            .navigationDestination(isPresented: $goToWelcomeView) {
                WelcomeView()
            }

            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Sign In")
                        .font(.system(.largeTitle, design: .monospaced))
                        .bold()
                        .foregroundColor(.white)
                }
            }

            .padding(.top, 40)
            .background(Color.darkGray.ignoresSafeArea())
        }
        .tint(.white)
    }
}

#Preview {
    SignInView()
}

extension SignInView {
    var arrowAndtitle: some View {
        HStack(alignment: .center) {
//            Image(systemName: "arrow.left")
//                .font(.system(size: 30).bold())
//
            Text("SIGN IN")
                .font(.system(.largeTitle, design: .monospaced))
                .bold()
        }
        .foregroundColor(.white)
    }

    var description: some View {
        Text("Enter your email address to create your Brick account or access your existing one. No password needed.")
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
    }

    var textFieldForEmail: some View {
        ZStack(alignment: .leading) {
            if email.isEmpty {
                Text("ENTER EMAIL")
                    .font(.system(.title3, design: .monospaced))
                    .foregroundColor(.white)
                    .padding(.leading, 30)
            }

            TextField("", text: $email)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 1)
                )
                .padding(.horizontal)
        }
    }

    var signInButton: some View {
        Button(action: {
            goToWelcomeView = true

        }) {
            Text("SIGN IN")
                .font(.system(.title3, design: .monospaced))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.lightGray)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }

//    var textButton: some View {
//        Button(action: {
//            // Show explanation
//        }) {
//            Text("WHY DO WE HAVE ACCOUNTS?")
//                .font(.system(.subheadline, design: .monospaced))
//                .italic()
//                .foregroundColor(.gray)
//                .underline()
//        }
//
//    }
//
}
