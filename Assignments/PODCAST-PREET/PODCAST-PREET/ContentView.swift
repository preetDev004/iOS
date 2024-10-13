//  ContentView.swift
//  PODCAST-PREET
//
//  Created by Preet Patel on 01/10/24.

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // Main view VStack
        VStack {
            Spacer()
            // Podcast cover Image
            Image(.podcast)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(8)
            
            // Played time & total time
             HStack{
                 Text("00:00")
                     .font(.system(size: 14))
                     .foregroundStyle(.white)
                 
                 // Playing timeline
                 Rectangle()
                     .foregroundStyle(.white)
                     .frame(height: 4)
        
                 
                 Text("22:35")
                     .font(.system(size: 14))
                     .foregroundStyle(.white)
             }
             .padding(.horizontal,8)
            
            Spacer()
            // Podcast title with add to playlist button
            HStack{
                VStack(alignment: .leading){
                    Text("Ep 1: Too Close to See? (ICP)")
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    
                    Text("Death, Lies & Cyanide")
                        .font(.system(size: 18))
                        .foregroundStyle(Color(red:220/255,green: 220/255,blue: 220/255))
                }
                Spacer()
                
                HStack(alignment: .bottom){
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.white)
                        .font(.system(size: 28))
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.white)
                        .font(.system(size: 28))
                }
                
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Scrollview having the description of the podcast
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("About the episode")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text("Theirs was a close-knit family, living in a small neighbourhood. And yet, when six suspicious deaths happened, no one raised even an eyebrow. Least of all, suspected their favourite daughter-in-law - Jolly.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color(red:220/255, green: 220/255, blue: 220/255))

                }
                .padding(4)
            }
            .padding(8)
            .frame(height: 100) // Fixed height of 100
            .background(Color(red:24/255, green:24/255, blue:24/255))
           
            Spacer()
            // Playing, forward 10 seconds, backword 10 seconds icon.
            HStack{
                Image(systemName: "gobackward.10")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .font(.system(size: 38))
                
                Spacer()
                
                Image(systemName: "play.fill")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .font(.system(size: 54))
                
                Spacer()
                
                Image(systemName: "goforward.10")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .font(.system(size: 38))
            }
            .padding(.horizontal, 8)
            
            Spacer()
            
        }
        .padding()
        .background(Color(red:176/255, green:15/255, blue:18/255))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

#Preview {
    ContentView()
}
