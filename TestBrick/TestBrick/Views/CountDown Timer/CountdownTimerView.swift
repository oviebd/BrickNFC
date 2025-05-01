//
//  CountdownTimerView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 1/5/25.
//

import SwiftUI

struct CountdownTimerView: View {
    @StateObject private var viewModel = CountdownTimerViewModel()

       var body: some View {
           VStack(spacing: 20) {
               Text("Elapsed Time: \(formatTime(viewModel.elapsedTime))")
                   .font(.title)
                   .monospacedDigit()

               Button("Start Timer") {
                   viewModel.saveCurrentTimestampAndStart()
               }

               Button("Reset") {
                   viewModel.reset()
               }
           }
           .padding()
           .onAppear {
               viewModel.startOrResumeTimer()
           }
           .onDisappear {
               viewModel.stopTimer()
           }
       }

       private func formatTime(_ interval: TimeInterval) -> String {
           let seconds = Int(interval) % 60
           let minutes = (Int(interval) / 60) % 60
           let hours = Int(interval) / 3600
           return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
       }
}

#Preview {
    CountdownTimerView()
}
