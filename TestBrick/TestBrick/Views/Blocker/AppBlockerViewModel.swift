//
//  AppBlockerViewModel.swift
//  Broke
//
//  Created by Habibur Rahman on 22/3/25.
//
import SwiftUI
import FamilyControls
import ManagedSettings

class AppBlockerViewModel: ObservableObject {
    
    var isAuthorized = false
    @Published var isBlocking = false
    @Published var selectedApps = FamilyActivitySelection()

    @Published var alertMessage : String = ""
    @Published var showAlert : Bool = false
    
    init () {
        loadBlockingState()
        loadSelectedApps()
    }
    
    func requestAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            DispatchQueue.main.async { [weak self] in
                self?.isAuthorized = true
            }
        } catch {
            print("Failed to request authorization: \(error)")
            DispatchQueue.main.async {  [weak self] in
                self?.isAuthorized = false
            }
        }
    }
    
    func setBlocking(isBlock : Bool){
        guard isAuthorized else {
            //print("Not authorized to block apps")
            alertMessage = "Not authorized to block apps"
            showAlert = true
            return
        }
        
        isBlocking = isBlock
        saveBlockingState()
        
        if isBlocking {
            blockSelectedApps()
        }else{
            unblockApps()
        }
        
    }
    
//    func toggleBlocking() {
//        guard isAuthorized else {
//            //print("Not authorized to block apps")
//            alertMessage = "Not authorized to block apps"
//            showAlert = true
//            return
//        }
//        
//        isBlocking.toggle()
//        saveBlockingState()
//        
//        if isBlocking {
//            blockSelectedApps()
//        }else{
//            unblockApps()
//        }
//    }
    
    func saveSelectedApps() {
        if let data = try? JSONEncoder().encode(selectedApps) {
            UserDefaults.standard.set(data, forKey: "selectedApps")
        }
    }
    
    func loadSelectedApps() {
        if let data = UserDefaults.standard.data(forKey: "selectedApps"),
           let savedSelection = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) {
            selectedApps = savedSelection
        }
    }
    
    private func loadBlockingState() {
        isBlocking = UserDefaults.standard.bool(forKey: "isBlocking")
    }
    
    private func saveBlockingState() {
        UserDefaults.standard.set(isBlocking, forKey: "isBlocking")
    }
    
    func blockSelectedApps() {
        loadSelectedApps()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.blockApps()
        }
        
    }
    
    private func blockApps(){
        let store = ManagedSettingsStore()
        
        let appsToBlock = selectedApps.applicationTokens
        store.shield.applications = appsToBlock

               // Fetch all apps inside the selected categories
        let categoriesToBlock = selectedApps.categoryTokens // Correct way to get category tokens
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categoriesToBlock)
       
        alertMessage = "Selected Apps are blocked"
        showAlert = true
    }

    func unblockApps() {
        let store = ManagedSettingsStore()
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        print("All apps are now unblocked")
        
        alertMessage = "All apps are now unblocked"
        showAlert = true
    }
}
