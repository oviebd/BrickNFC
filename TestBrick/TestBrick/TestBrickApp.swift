//
//  TestBrickApp.swift
//  TestBrick
//
//  Created by Habibur Rahman on 28/4/25.
//

import SwiftUI

@main
struct TestBrickApp: App {
    @StateObject private var appBlocker = AppBlocker()

    var body: some Scene {
        WindowGroup {
            SignInView()
           // ContentView()
                //  WhatGetsView()
                .environmentObject(appBlocker)
        }
    }
}
