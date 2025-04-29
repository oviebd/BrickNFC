//
//  WhatGetsView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct WhatGetsView: View {
    
    @StateObject private var viewModel = AppBlockerViewModel()
    @State private var showPicker = false
    
    var body: some View {
        VStack (spacing: 10){
            arrowAndtitle
            
            description
            
            Spacer()
           
            selectAppButton
            
            
            Spacer()
            selectedAppCountText
            continueButton
            
        }
        
        .padding(.top, 40)
        .background(Color.darkGray.ignoresSafeArea())
        .task {
            await viewModel.requestAuthorization()
        }.onAppear {
            showPicker = true
        }.familyActivityPicker(isPresented: $showPicker, selection: $viewModel.selectedApps)
        .onChange(of: showPicker) { newValue in
            if !newValue {
                print("Picker closed: User pressed OK or Cancel")
                viewModel.saveSelectedApps()
            }
        }
    }
}

#Preview {
    WhatGetsView()
}

extension WhatGetsView {
    var arrowAndtitle: some View {
        HStack(alignment: .center, spacing: 50) {
            // Spacer()
            Image(systemName: "arrow.left")
                .font(.system(size: 30).bold())
            
            Text(" WHAT GETS\nIN THE WAY?")
                .font(.system(.largeTitle, design: .monospaced))
                .bold()
            
        }
        .foregroundColor(.white)
        .padding(.trailing, 50)
        
    }
    
    var description: some View {
        Text("We'll start simple - let's have\n   this mode block your top3\n  distractions (you can update\n           this later)")
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
        
    }
    
    var selectedAppCountText : some View {
        Text("Select At least a app or category to continue")
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
        
    }
    
    var selectAppButton: some View {
        Button(action: {
            showPicker = true
        }) {
            HStack {
                Spacer()
                Text("Select App")
                    .font(.system(.title2, design: .monospaced))
                    .foregroundColor(.white)
                Spacer()
//                Image(systemName: "arrow.right")
//                    .font(.system(size: 20).bold())
//                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.lightGray)
            .cornerRadius(15)
        }
        .padding()
    }
    
    var continueButton: some View {
        Button(action: {
            if viewModel.canBlock {
                
            }
        }) {
            HStack {
                Spacer()
                Text("CONTINUE")
                    .font(.system(.title2, design: .monospaced))
                    .foregroundColor(viewModel.canBlock ? .white : .white.opacity(0.5))
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.system(size: 20).bold())
                    .foregroundColor(.white)
            }
            .padding()
            .background(viewModel.canBlock ? Color.lightGray : Color.lightGray.opacity(0.5))
            .cornerRadius(15)
        }
        .padding()
    }
    
    
    
}
