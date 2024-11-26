//
//  Screen2.swift
//  w12-Navigation
//
//  Created by Preet Patel on 26/11/24.
//

import SwiftUI
struct Screen2: View {
    var body: some View {
        VStack {
            Text("Hello World!")
                .font(.system(size:24))
            Text("This is screen #2")
        }
        .padding()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}
//#Preview {
//    Screen2()
//}
