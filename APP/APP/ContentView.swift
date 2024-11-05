//
//  ContentView.swift
//  APP
//
//  Created by Preet Patel on 04/11/24.
//

import SwiftUI

// Main ContentView with tabs
struct ContentView: View {
    @State private var sharedText: String = "Some shared data"
    var body: some View {
        TabView {
            FirstTabView(sharedText: $sharedText)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SecondTabView(sharedText: $sharedText)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

// First Tab View
struct FirstTabView: View {
    @Binding var sharedText : String
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextField("", text: $sharedText)
                .padding(10)
                .border(.black, width: 2)
                .cornerRadius(4)
        }
        .padding()
    }
}

// Second Tab View with shared data
struct SecondTabView: View {
    @Binding var sharedText: String
    var body: some View {
        VStack {
            Image(systemName: "star")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Second Tab")
            Text(sharedText)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
