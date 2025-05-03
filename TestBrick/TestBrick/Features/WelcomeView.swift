//
//  WelcomeView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var goToWhatGetsView: Bool = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
          
            upperView
            Spacer()
            middleView

            Spacer()
            continueButton
        }

        .navigationDestination(isPresented: $goToWhatGetsView) {
            AppSelectionView()
        }

        .navigationBarBackButtonHidden(true)
        .background(Color.darkGray.ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomTopToolbar(showBackButton: false)
            }
        }
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
    }
}

extension WelcomeView {
//    var backButton: some View {
//        HStack {
//
//            Button(action: {
//                dismiss()
//
//            }) {
//
//                HStack(spacing : 20){
//
//                    Image(systemName: "chevron.left")
//                        .font(.system(size: 20).bold())
//                        .foregroundColor(.white)
//
//
//                }
//
//
//            }
//            Spacer()
//        }.padding(.horizontal, 10)
//
//    }

    var upperView: some View {
        VStack(spacing: 10) {
            Text("WELCOME TO ⌘ REBORN")

                .font(.system(size: 25, design: .monospaced))
                // .font(.system(.title, design: .monospaced))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)

            Text("YOUR PHONE IS ABOUT TO\nBECOME A TOOL AGAIN")
                .font(.system(.headline, design: .monospaced))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(.horizontal)
    }

    var middleView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("""
            We believe technology should amplify your potential, not limit it.

            What started as a simple solution for our own distractions became a tool that changed how we engaged with technology, reclaiming our time and focus.

            Our goal is to help you transform your relationship with tech, empowering you to pursue what truly matters. Brick is just the start.

            We're excited to see how you use it.
            """)
            .font(.system(.body, design: .monospaced))
            .foregroundStyle(.white.opacity(0.8))
            .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }

    var continueButton: some View {
        Button(action: {
            goToWhatGetsView = true

        }) {
            HStack {
                Spacer()
                Text("CONTINUE")
                    .font(.system(.title2, design: .monospaced))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.system(size: 20).bold())
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.lightGray)
            .cornerRadius(15)
        }
        .padding()
    }
}
