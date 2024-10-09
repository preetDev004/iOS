//
//  ContentView.swift
//  w6
//
//  Created by Preet Patel on 08/10/24.
//

import SwiftUI
struct ContentView: View {
    @State private var favCity: String = ""
    @State private var flightPrice: String = ""
    @State private var showPrice: Bool = false
    
    var body: some View {
        let _ = Self._printChanges()
        VStack {
 
            TextField("Enter your favorite city...", text: $favCity)
                .padding(10)
                .border(.gray)
            
            TextField("Enter the price of the ticket...", text: $flightPrice)
                .padding(10)
                .border(.gray)
                .keyboardType(.decimalPad)
            
            Button("Calculate Next Year's Price") {
                if !favCity.isEmpty, let _ = Double(flightPrice) {
                    showPrice = true // Set flag to true on valid input and button press
                }
            }
            .padding()
            .foregroundStyle(.black)
            .background(.yellow)
            .cornerRadius(8)
            
            if showPrice {
                let nextYearPrice = (flightPrice as NSString).doubleValue + ((flightPrice as NSString).doubleValue * 0.2)
                Text("Next year, your flight to \(favCity) will cost \(nextYearPrice, specifier: "%.2f")")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
