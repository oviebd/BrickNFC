//
//  ActivateView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct ActivateView: View {
    var body: some View {
        
        ZStack {
                    
                    Color.darkGray.ignoresSafeArea()
                    
                    VStack(spacing: 30) {
                        topView
                        detalis
                        
                        Spacer()
                        acitvateButton
                        
                        Spacer()
                        brickButton
                        
                        Spacer()
                    }
                    .padding(.top, 40)
                }
            }
    
}

#Preview {
    ActivateView()
}

extension ActivateView {
    var topView: some View {
    HStack(alignment: .center, spacing: 50) {
      
        Image(systemName: "arrow.left")
            .font(.system(size: 30))
        
        Text(" ACTIVATE\nYOUR BRICK")
            .font(.system(.largeTitle, design: .monospaced))
            .bold()
        
    }
    .foregroundColor(.white)
    .padding(.trailing, 60)
    
}
    
    var detalis: some View {
        
            Text(" Tap the button below, and then\n  tap the top of your phone to\n    your Brick to activate.")
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            
        
    }
    
    var acitvateButton: some View {
        Button(action: {
            print("Activate button tapped")
        }) {
            Text("ACTIVATE")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
            
                .frame(width: 150, height: 150)              .background(Color.lightGray)
                
                .cornerRadius(20)
        }
        .padding(.horizontal)
        
        

    }
    
    
    var brickButton: some View {
        Button(action: {
            // Show explanation
        }) {
            Text("Don't have a Brick?")
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(.white.opacity(0.8))
                .underline()
        }
        
    }
    
}
