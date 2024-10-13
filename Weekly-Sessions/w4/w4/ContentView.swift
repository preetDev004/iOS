//
//  ContentView.swift
//  w4
//
//  Created by Preet Patel on 26/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName:"bird.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundStyle(Color(red:0.96, green: 0.69, blue: 0.09))
               
//            fixed size
                .font(.system(size: 36, weight: .bold, design: .default))
                .background(Color.black)
            Spacer()
        }
        .padding()
        HStack{
            Text("Welcome to the apple watch")
                .font(.largeTitle).foregroundStyle(.blue).background(.white)
        }.padding()
    }
}

#Preview {
    ContentView()
}
