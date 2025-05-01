//
//  WhatGetsView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct WhatGetsView: View {
    @StateObject private var viewModel = AppBlockerViewModel()
    @State private var showPicker = false
    @State private var goToLockUnLockView: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            arrowAndtitle
            Spacer()
                .frame(height: 10)
            description

            Spacer()

            selectAppButton

            Spacer()
            selectedAppCountText
            continueButton
        }
        .navigationDestination(isPresented: $goToLockUnLockView) {
            LockUnlockView()
        }

        

        .background(Color.darkGray.ignoresSafeArea())

        .navigationBarBackButtonHidden(true)

        .task {
            await viewModel.requestAuthorization()
        }.familyActivityPicker(isPresented: $showPicker, selection: $viewModel.selectedApps)
        .onChange(of: showPicker) { newValue in
            if !newValue {
                print("Picker closed: User pressed OK or Cancel")
                viewModel.saveSelectedApps()
            }
        }
    }
}

#Preview {
    NavigationStack {
        WhatGetsView()
    }
}

extension WhatGetsView {
    var arrowAndtitle: some View {
        VStack {
            Text("WHAT GETS")
            Text("IN THE WAY?")
        }.padding(.top, 50)
            .font(.system(.largeTitle, design: .monospaced))
            .bold()
            .foregroundColor(.white)
    }

    var description: some View {
        Text("We'll start simple - let's have\n   this mode block your top3\n  distractions (you can update\n           this later)")
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
    }

    var selectedAppCountText: some View {
        Text("Select At least a app or category to continue")
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
    }

    var selectAppButton: some View {
        Button(action: {
            showPicker = true
        }) {
            HStack {
                Spacer()
                Text("Select App")
                    .font(.system(.title2, design: .monospaced))
                    .foregroundColor(.white)
                Spacer()
//                Image(systemName: "arrow.right")
//                    .font(.system(size: 20).bold())
//                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.lightGray)
            .cornerRadius(15)
        }
        .padding()
    }

    var continueButton: some View {
        Button(action: {
//            if viewModel.canBlock {
//                goToLockUnLockView = true
//            }

            goToLockUnLockView = true

        }) {
            HStack {
                Spacer()
                Text("CONTINUE")
                    .font(.system(.title2, design: .monospaced))

                Spacer()
                Image(systemName: "arrow.right")
                    .font(.system(size: 20).bold())
                //  .foregroundColor(viewModel.canBlock ? .white : .white.opacity(0.5))
            }.foregroundColor(viewModel.canBlock ? .white : .white.opacity(0.5))
                .padding()
                .background(viewModel.canBlock ? Color.lightGray : Color.lightGray.opacity(0.5))
                .cornerRadius(15)
        }
        .padding()
    }
}
