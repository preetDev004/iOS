//
//  Screen3.swift
//  w12-Navigation
//
//  Created by Preet Patel on 26/11/24.
//

import SwiftUI

struct Screen3: View {
    
    // properties to store incoming data
    var favNumber:Int
    var likesDogs:Bool
    var city:String
    var favColor:Color
    
    var body: some View {
        VStack{
            Text("This is screen 3")
                .font(.system(size:20))
            
            Text("Favorite number: \(favNumber)")
            Text("Do you like dogs: \(String(likesDogs))")
            Text("City: \(city)")
            
            Text("What color is the background?")
                .background(favColor)
            
        }
        .padding()
        .navigationTitle("Info")
        .navigationBarTitleDisplayMode(.large)
        
    }
}

//
//#Preview {
//    Screen3(favNumber: 7, likesDogs: true, city: "Ahemdabad", favColor: .red)
//}
