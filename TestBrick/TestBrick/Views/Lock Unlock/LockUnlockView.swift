//
//  LockUnlockView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct LockUnlockView: View {
    @EnvironmentObject private var appBlocker: AppBlocker

    @StateObject private var nfcReader = NFCReader()

    @StateObject private var appBlockerVM = AppBlockerViewModel()
    @AppStorage("isBlocking") private var isBlocking: Bool = true
    @Environment(\.dismiss) private var dismiss
    @State private var goToWhatGetsView: Bool = false
//    @StateObject var vm = SecondVM()

    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()

            VStack {

                if isBlocking {
                    LockView()
                } else {
                    UnLockView()
                }
            }
        }
        .navigationDestination(isPresented: $goToWhatGetsView) {
            WhatGetsView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                    // goToWhatGetsView = true
                }) {
                    
                    CustomTopToolbar(showBackButton: true)
                    
                   
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LockUnlockView()
    }
}

extension LockUnlockView {
    var topView: some View {
        HStack(alignment: .center, spacing: 50) {
            Image(systemName: "arrow.left")
                .font(.system(size: 30))

            Text("ACTIVATE\nYOUR BRICK")
                .font(.system(.largeTitle, design: .monospaced))
                .bold()
        }
        .foregroundColor(.white)
        .padding(.trailing, 60)
    }
}
