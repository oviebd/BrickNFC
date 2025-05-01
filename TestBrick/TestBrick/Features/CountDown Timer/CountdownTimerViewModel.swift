//
//  CountdownTimerViewModel.swift
//  TestBrick
//
//  Created by Habibur Rahman on 1/5/25.
//

import Foundation
import Combine
import SwiftUI

final class CountdownTimerViewModel: ObservableObject {

    @Published var elapsedTime: TimeInterval = 0
    private var timer: AnyCancellable?
    private let store = UserDefaultDataStoreManager.shared
    private let key = AppConstants.UserDefaultsKeys.lastActionTimestamp

    private var lastActionDate: Date? {
        store.get(forKey: key, as: Date.self)
    }

    func startOrResumeTimer() {
        if let savedDate = lastActionDate {
            updateElapsedTime(from: savedDate)
            startTimer(from: savedDate)
        }
    }

    func saveCurrentTimestampAndStart() {
        let now = Date()
        store.set(now, forKey: key)
        updateElapsedTime(from: now)
        startTimer(from: now)
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
    }

    private func updateElapsedTime(from startDate: Date) {
        elapsedTime = Date().timeIntervalSince(startDate)
    }

    private func startTimer(from startDate: Date) {
        stopTimer()
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateElapsedTime(from: startDate)
            }
    }

    func reset() {
        store.remove(forKey: key)
        elapsedTime = 0
        stopTimer()
    }
}
