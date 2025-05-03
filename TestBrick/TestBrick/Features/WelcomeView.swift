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
        VStack(spacing: 10) {
          
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

            Text("YOUR PHONE IS ABOUT TO BECOME YOUR ALLY AGAIN")
                .font(.system(.headline, design: .monospaced))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(.horizontal)
    }

    var middleView: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            ScrollView (){
                Text("""
                We believe tech should serve your growth — not steal your time.

                At 21, we created Reborn after realizing how often our phones were pulling us away from the life we wanted.
                
                What began as a personal fix became a powerful way to take back control, helping us reconnect with focus, energy, and real goals.

                Our mission is to help you shift how you use technology — so it pushes you forward instead of holding you back. Reborn is only the beginning.

                We can’t wait to see what you’ll do with it.
                """)
                //.font(.system(size: 18, design: .monospaced))
                .font(.system(.body, design: .monospaced))
                .foregroundStyle(.white.opacity(0.8))
                .multilineTextAlignment(.leading)
            }.scrollIndicators(.hidden)
            
          
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
