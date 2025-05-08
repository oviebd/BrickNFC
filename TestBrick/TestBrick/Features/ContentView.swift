//
//  ContentView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 28/4/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(AppConstants.UserDefaultsKeys.isLoggedIn) private var isLoggedIn: Bool = false

    @AppStorage(AppConstants.UserDefaultsKeys.isBlocking) private var isInBlockingState: Bool = false
  
    
    var body: some View {
        NavigationStack {
            Group {
                
               // SignInView()
                if isInBlockingState {
                    LockUnlockView()
                } else {
                    if isLoggedIn {
                        WelcomeView()
                    } else {
                        SignInView()
                    }
                }
            }
        }.id(isLoggedIn)
        .tint(.white)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
