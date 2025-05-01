//
//  ContentView.swift
//  TestBrick
//
//  Created by Habibur Rahman on 28/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Go to Detail", destination: DetailView())
            }
            .navigationTitle("Home")
        }
        .tint(.red) // Still apply here
    }
}

#Preview {
    NavigationStack{
        ContentView()
    }
    }
   

struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .navigationTitle("Detail")
            .navigationBarBackButtonHidden(false)
           // .tint(.red) // THIS is crucial – apply tint inside the destination
    }
}

