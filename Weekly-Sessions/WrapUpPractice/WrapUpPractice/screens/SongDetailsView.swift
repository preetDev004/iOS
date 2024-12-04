//
//  SongDetailsView.swift
//  WrapUpPractice
//
//  Created by Preet Patel on 03/12/24.
//

import SwiftUI

struct SongDetailsView: View {
    @State var song: Song
    @State private var isFavorite = false
    var body: some View {
        Text("\(song.name)")
            .navigationTitle("Song Details")
        
        Button(action: {
                    // Trigger haptic feedback
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                    
                    // Toggle favorite state with animation
                    withAnimation(.spring()) {
                        isFavorite.toggle()
                    }
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(isFavorite ? .red : .gray)
                        // Add a pulsing scale effect when favorited
                        .scaleEffect(isFavorite ? 1 : 0.8)
                }
                .frame(width: 35, height: 35)
    }
}

//#Preview {
//    SongDetailsView()
//}
