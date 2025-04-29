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
    @AppStorage("isBlocking") private var isBlocking: Bool = false

//    @StateObject var vm = SecondVM()

    var body: some View {
        ZStack {
            Color.lightGray
                .ignoresSafeArea()

            if isBlocking {
                LockView()
            } else {
                UnLockView()
            }
        }
    }
}

#Preview {
    LockUnlockView()
}
