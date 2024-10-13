//
//  ContentView.swift
//  w5
//
//  Created by Preet Patel on 01/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isClicked = false
    var body: some View {
        //
        //        VStack {
        //            Spacer()
        //            Image(systemName: "globe")
        //                .imageScale(.large)
        //                .foregroundStyle(isClicked ? .purple : .blue)
        //
        //            Spacer()
        //                Text("Hello, world!")
        //                        .frame(width: 140, height: 40, alignment: .center)
        //                        .foregroundStyle(.yellow)
        //                        .fontWeight(.bold)
        //                        .padding(10)
        //                        .border(.black, width: 1)
        //                        .background(isClicked ? .purple : .blue)
        //                        .cornerRadius(10)
        //                        .onTapGesture {
        //                            isClicked.toggle()
        //                        }
        //                        Spacer()
        //
        //        }
        //        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .padding()
        //        .border(.red)
        //
        
//        HStack{
//            Spacer()
//            Text("One").frame(width: 90 ,height: 90)
//                .background(.red)
//            Text("Two").frame(width: 90 ,height: 90)
//                .background(.yellow)
//            Text("Three").frame(width: 90 ,height: 90)
//                .background(.cyan)
//          
//        }
//        
//        .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .trailing)
//        .border(.blue)
        
//        VStack{
//            Text("skillUp")
//                .font(.title2)
//            Spacer()
//            Text("Choose from 210,000+ courses")
//                .font(.title)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.center)
//            
//            Spacer()
//            Text("Find out at www.skillUp.com")
//        }
//        .frame(maxWidth: .infinity ,maxHeight: .infinity)
//        .background(.yellow)
//    }
    VStack{
        
        Spacer()
        Image(.shape04).resizable().frame(width: 500, height: 350)
            .aspectRatio(contentMode: .fit)
        Text("Welcome")
            .font(.system(size: 40))
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
        Text("We are so glad you are here")
            .font(.headline)
            Spacer()
         
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(.yellow)
    }
    
    
}

#Preview {
    ContentView()
}
