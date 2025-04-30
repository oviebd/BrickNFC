//
//  WhatGetsView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 29/4/25.
//

import SwiftUI

struct WhatGetsView: View {
    var body: some View {
        VStack (spacing: 30){
            arrowAndtitle
            
            description
            
            Spacer()
            continueButton
            
        }
        
        .padding(.top, 40)
        .background(Color.darkGray.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
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
    
    var continueButton: some View {
        Button(action: {
           
        }) {
            HStack {
                Spacer()
                Text("CONTINUE")
                    .font(.system(.title2, design: .monospaced))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.system(size: 20).bold())
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.lightGray)
            .cornerRadius(15)
        }
        .padding()
    }
    
    
    
}
