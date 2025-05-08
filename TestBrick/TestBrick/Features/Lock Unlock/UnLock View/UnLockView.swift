//
//  UnLockView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct UnLockView: View {
    @EnvironmentObject private var appBlocker: AppBlocker

    @StateObject private var nfcReader = NFCReader()
    @StateObject private var appBlockerVM = AppBlockerViewModel()

    @StateObject var vm = LockUnlockVM()
    @State private var goSettingView: Bool = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.darkGray.ignoresSafeArea()

            VStack(spacing: 30) {
                topView

                Spacer()
                    .frame(height: 10)
                detalis

                Spacer()
                acitvateButton

                Spacer()
                brickButton

                Spacer()
            }
        }.task {
            await appBlockerVM.requestAuthorization()
        }
        .navigationDestination(isPresented: $goSettingView) {
            SettingsView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomTopToolbar(showBackButton: false)
                }
                
                // Settings button on the right
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Setting pressed")
                        goSettingView = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Circle().fill(Color.gray.opacity(0.3)))
                            .font(.system(size: 10, weight: .bold))
                    }
                }
        }
    }
}

extension UnLockView {
    func scanTag() {
//        appBlockerVM.setBlocking(isBlock: true)
//        return
        nfcReader.scan { payload in
            let isValid = vm.isValidTag(tag: payload)
            if isValid {
                appBlockerVM.setBlocking(isBlock: true)
            } else {
                vm.alertMessae = "Wrong Tag!. Please use valid tag"
            }
        }
    }
}

#Preview {
    NavigationStack{
        UnLockView()
    }
    
}

extension UnLockView {
    var topView: some View {
        HStack(alignment: .center, spacing: 50) {
            Text("ACTIVATE YOUR REBORN")
                .font(.system(size: 40, design: .monospaced))
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)

        }
        .foregroundColor(.white)
    }

    var detalis: some View {
        Text(" Tap the button below, and then\ntap the top of your phone to\nyour Reborn to activate.")
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
    }

    var acitvateButton: some View {
        Button(action: {
            scanTag()
        }) {
            Text("ACTIVATE")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

                .frame(width: 150, height: 150).background(Color.lightGray)

                .cornerRadius(20)
        }
        .padding(.horizontal)
    }

    var brickButton: some View {
        Button(action: {
            // Show explanation

        }) {
            Text("Don't have a Reborn?")
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(.white.opacity(0.8))
                .underline()
        }
    }
}
