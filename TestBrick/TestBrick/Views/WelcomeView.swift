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
        NavigationStack {
            VStack(spacing: 20) {
                backButton
                upperView
                Spacer()
                middleView
                
                Spacer()
                continueButton
                
            }
            
            .navigationDestination(isPresented: $goToWhatGetsView) {
                WhatGetsView()
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.darkGray.ignoresSafeArea())
        }
    }
    
    }


#Preview {
    WelcomeView()
}

extension WelcomeView {
    
    var backButton: some View {
        HStack {
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 30).bold())
                    .foregroundColor(.white) 
            }
            Spacer()
        }.padding(.horizontal, 20)
        
    }
    
    var upperView: some View {
        VStack(spacing: 10) {
            Text("WELCOME TO ⌘ BRICK")
                .font(.system(.title, design: .monospaced))
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

As two 23 year olds, we built Brick because we found ourselves stuck in patterns with our phones that held us back.

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
    

