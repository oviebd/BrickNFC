//
//  AppBlocker.swift
//  Broke
//
//  Created by Oz Tamir on 22/08/2024.
//
import SwiftUI
import ManagedSettings
import FamilyControls

class AppBlocker: ObservableObject {
 //   let store = ManagedSettingsStore()
    @Published var isBlocking = false
    @Published var isAuthorized = false
    
    let appBlockingUserDefaultDataManager = AppBlockerUserDefaultDataManager.shared
    
    init() {
        loadBlockingState()
        Task {
            await requestAuthorization()
        }
    }
    
    func requestAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            DispatchQueue.main.async {
                self.isAuthorized = true
            }
        } catch {
            print("Failed to request authorization: \(error)")
            DispatchQueue.main.async {
                self.isAuthorized = false
            }
        }
    }
    
    func toggleBlocking() {
        guard isAuthorized else {
            print("Not authorized to block apps")
            return
        }
        
        isBlocking.toggle()
        saveBlockingState()
       // applyBlockingSettings()
//        applyBlockingSettings(for: profile)
    }
    
//    func applyBlockingSettings(for profile: Profile) {
//        if isBlocking {
//            NSLog("Blocking \(profile.appTokens.count) apps")
//            store.shield.applications = profile.appTokens.isEmpty ? nil : profile.appTokens
//            store.shield.applicationCategories = profile.categoryTokens.isEmpty ? ShieldSettings.ActivityCategoryPolicy.none : .specific(profile.categoryTokens)
//        } else {
//            store.shield.applications = nil
//            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none
//        }
//    }
    
    
    
    func applyBlockingSettings() {
//        if isBlocking {
//            NSLog("Blocking \(profile.appTokens.count) apps")
//            store.shield.applications = profile.appTokens.isEmpty ? nil : profile.appTokens
//            store.shield.applicationCategories = profile.categoryTokens.isEmpty ? ShieldSettings.ActivityCategoryPolicy.none : .specific(profile.categoryTokens)
//        } else {
//            store.shield.applications = nil
//            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none
//        }
    }
    
    private func loadBlockingState() {
        isBlocking = appBlockingUserDefaultDataManager.isBlockingEnabled()
    }
//    
    private func saveBlockingState() {
        appBlockingUserDefaultDataManager.setBlockingEnabled(isBlocking)
    }
}
