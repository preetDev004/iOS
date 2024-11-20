//
//  ContentView.swift
//  w11-Firebase
//
//  Created by Preet Patel on 20/11/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct ContentView: View {

    let db = Firestore.firestore()
    @State var nameFromUI:String = ""
    @State var gpaFromUI:String = ""
    @State var isDiplomaFromUI:Bool = false
    @State var studentList:[Student] = []
    
    var body: some View {
        VStack {
            Text("Database Demo")
                .font(.system(size:20))
                .padding(8)
                    
            TextField("Enter student name", text:$nameFromUI)
                .padding(8).border(Color.gray)
            TextField("Enter gpa", text:$gpaFromUI)
                .padding(8).border(Color.gray)
                .keyboardType(.numberPad)
            Toggle("Is Post Grad?", isOn:$isDiplomaFromUI)
                    
                    
            Button("Insert") {
                        // TODO
            }
                    

            Button("Get One"){
                        // TODO
            }
                    
            Button("Get All") {
                        // TODO
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
