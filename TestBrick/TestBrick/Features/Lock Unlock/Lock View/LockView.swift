//
//  LockView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct LockView: View {
    @EnvironmentObject private var appBlocker: AppBlocker

    @StateObject private var nfcReader = NFCReader()
    @StateObject private var appBlockerVM = AppBlockerViewModel()
    @StateObject var vm = LockUnlockVM()
    @StateObject private var countDownVM = CountdownTimerViewModel()

    var body: some View {
        ZStack {
            Color.darkGray.ignoresSafeArea()

            VStack(spacing: 30) {
                topView

                Spacer()
                    .frame(height: 10)
                detalis

                Spacer()
                acitvateButton
                timerView

                Spacer()
                brickButton

                Spacer()
            }
            // .padding(.top, 40)
            .task {
                await appBlockerVM.requestAuthorization()
            }.onAppear {
                countDownVM.startOrResumeTimer()
            }
        }
    }
}

extension LockView {
    func scanTag() {
//        appBlockerVM.setBlocking(isBlock: false)
//        return

        nfcReader.scan { payload in
            let isValid = vm.isValidTag(tag: payload)
            if isValid {
                appBlockerVM.setBlocking(isBlock: false)
            } else {
                vm.alertMessae = "Wrong Tag!. Please use valid tag"
            }
        }
    }
}

#Preview {
    LockView()
}

extension LockView {
    var topView: some View {
        HStack(alignment: .center, spacing: 50) {
            Text("DEACTIVATE\nYOUR BRICK")
                .font(.system(.largeTitle, design: .monospaced))
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
        }

        .foregroundColor(.white)
    }

    var timerView: some View {
        HStack(alignment: .center, spacing: 50) {
            Text("Elapsed Time:\n\(countDownVM.formatTime(countDownVM.elapsedTime))")
                .font(.system(.largeTitle, design: .monospaced))
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
        }

        .foregroundColor(.white)
    }

    var detalis: some View {
        Text(" Tap the button below, and then\ntap the top of your phone to\nyour Brick to activate.")
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    var acitvateButton: some View {
        Button(action: {
            scanTag()
        }) {
            Text("DEACTIVATE")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

                .frame(width: 150, height: 150).background(Color.lightGray)

                .cornerRadius(20)
        }
        .padding(.horizontal)
    }

    var brickButton: some View {
        Button(action: {
        }) {
            Text("Don't have a Brick?")
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(.white.opacity(0.8))
                .underline()
        }
    }
}
