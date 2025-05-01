//
//  AppBlockerView.swift
//  Broke
//
//  Created by Habibur Rahman on 22/3/25.
//


import SwiftUI
import FamilyControls
import ManagedSettings

//App blocker 
struct AppBlockerView: View {
    @StateObject private var viewModel = AppBlockerViewModel()
    @State private var showPicker = false
   
    
    var body: some View {
        VStack {
            Button("Select Apps to Block") {
                showPicker = true
            }
            .familyActivityPicker(isPresented: $showPicker, selection: $viewModel.selectedApps)

            Button("Block Selected Apps") {
                blockSelectedApps()
            }
            .disabled(viewModel.selectedApps.applicationTokens.isEmpty)
            .padding()

            Button("Unblock All Apps") {
                unblockApps()
            }
            .padding()
        }.onChange(of: viewModel.selectedApps, perform: {  newValue in
            viewModel.saveSelectedApps()
        })
        
        .task {
            await viewModel.requestAuthorization()
        }
    }


    func blockSelectedApps() {
        let store = ManagedSettingsStore()
        store.shield.applications = viewModel.selectedApps.applicationTokens
        
        print("Blocked apps: \(viewModel.selectedApps.applicationTokens)")
    }

    func unblockApps() {
        let store = ManagedSettingsStore()
        store.shield.applications = nil
        print("All apps are now unblocked")
    }
    
    private func loadBlockingState() {
        viewModel.isBlocking = UserDefaults.standard.bool(forKey: "isBlocking")
    }
    
    private func saveBlockingState() {
        UserDefaults.standard.set(viewModel.isBlocking, forKey: "isBlocking")
    }
}
#Preview {
    AppBlockerView()
}
