//
//  LockUnlockVM.swift
//  NoNetNFC
//
//  Created by Habibur Rahman on 9/4/25.
//

import Foundation

class LockUnlockVM : ObservableObject {
    
    @Published var showAlert : Bool = false
    @Published var alertMessae : String = ""
    
    let tagPhrase = "001"
    
    func isValidTag(tag : String) -> Bool {
        return tag == tagPhrase
    }
    
    private func loadBlockingState() -> Bool {
       let isBlocking = UserDefaults.standard.bool(forKey: "isBlocking")
        return isBlocking
    }
    
    private func saveBlockingState(isBlocking : Bool) {
        UserDefaults.standard.set(isBlocking, forKey: "isBlocking")
    }
    
    
    
}

