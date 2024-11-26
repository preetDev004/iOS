//
//  ContentView.swift
//  w12-Navigation
//
//  Created by Preet Patel on 26/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Tabview will be fixed and serve different pupose than NavigationStack
        // you cant pass data and go backward and forward
        TabView{
            Screen2().tabItem{
                Label("Settings", systemImage: "gear")
                
                
            }
            Screen3(favNumber: 7, likesDogs: true, city: "Ahemdabad", favColor: .purple).tabItem{
                Label("Info", systemImage: "info.circle.fill")
                    
            }
        }
        
        
        // Navigate to different screen when you want then use:
//        NavigationStack{
//            Spacer()
//            Text("Main Screen")
//            Spacer()
//            HStack{
//                Spacer()
//                NavigationLink {
//                  Screen2()
//               } label: {
//                  Label("Settings", systemImage: "gear")
//                       .font(.headline)
//                       .foregroundStyle(.black)
//                       .imageScale(.large)
//               }
//                Spacer()
//                NavigationLink {
//                    Screen3(favNumber: 7, likesDogs: true, city: "Ahemdabad", favColor: .purple)
//               } label: {
//                  Label("Info", systemImage: "info.circle.fill")
//                       .font(.headline)
//                       .foregroundStyle(.black)
//                       .imageScale(.large)
//                       
//               }
//                .navigationTitle("Home")
//                .navigationBarTitleDisplayMode(.large)
//                Spacer()
//            }
//            .padding()
//            
//        }
    }
}

#Preview {
    ContentView()
}
