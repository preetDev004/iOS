//
//  ContentView.swift
//  w8
//
//  Created by Preet Patel on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cities:[String] = ["Mumbai", "Toronto", "New York", "Seoul", "Beijing"]
    
    @State var cityFormUI: String = ""
    var body: some View {
//        VStack {
//            List{
//                Section{
//                    Text("Wi-Fi")
//                    Text("Bluetooth")
//                    Text("Cellular")
//                        .listRowBackground(Color.green)
//                } header: {
//                    Text("Network")
//                } footer: {
//                    Text("All the information here can be modified upon user need!")
//                }
//                Section{
//                    Text("Accessibility")
//                        .listRowBackground(Color.blue)
//                    Text("General")
//                    Text("Wallpaper")
//                } header: {
//                    Text("System")
//                } footer: {
//                    
//                }
//            }
//        
//        }
        
       
        
        
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("Add a City")
                TextField("Enter a City", text: $cityFormUI)
                    .padding(8)
                    .border(.gray, width: 2)
                    .cornerRadius(2)
                Button("Add City"){
                    if(cityFormUI != ""){
                        cities.append(cityFormUI)
                        cityFormUI = ""
                    }
                    
                }
                .padding(10)
                .background(.blue)
                .foregroundStyle(.white)
                .cornerRadius(8)
                .padding(.top)
             
            }.padding()
            List{
                Section{
                    ForEach(Array(cities.enumerated()), id:\.offset){ (index, city) in
                        
                        HStack{
                            VStack(alignment: .leading){
                                Text(city)
                                
                            }
                            Spacer()
                            Button("Update"){
                                if(cityFormUI != ""){
                                    cities[index] = cityFormUI
                                    cityFormUI = ""
                                }
                            }
                            .buttonStyle(.borderless)
                                                        
                        }
                       
                    }
                    .onDelete(perform: {
                        indexSet in
                        cities.remove(atOffsets: indexSet)
                    })
                } header :{
                    Text("Cities")
                } footer :{
                    Text("All the cities are added by you are shown here.")
                }
               
            }
            
        }
    }
}

#Preview {
    ContentView()
}
