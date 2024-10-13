//
//  ContentView.swift
//  w6
//
//  Created by Preet Patel on 08/10/24.
//

import SwiftUI
//struct ContentView: View {
//    @State private var favCity: String = ""
//    @State private var flightPrice: String = ""
//    @State private var showPrice: Bool = false
//    
//    var body: some View {
//        let _ = Self._printChanges()
//        VStack {
// 
//            TextField("Enter your favorite city...", text: $favCity)
//                .padding(10)
//                .border(.gray)
//            
//            TextField("Enter the price of the ticket...", text: $flightPrice)
//                .padding(10)
//                .border(.gray)
//                .keyboardType(.decimalPad)
//            
//            Button("Calculate Next Year's Price") {
//                if !favCity.isEmpty, let _ = Double(flightPrice) {
//                    showPrice = true // Set flag to true on valid input and button press
//                }
//            }
//            .padding()
//            .foregroundStyle(.black)
//            .background(.yellow)
//            .cornerRadius(8)
//            
//            if showPrice {
//                let nextYearPrice = (flightPrice as NSString).doubleValue + ((flightPrice as NSString).doubleValue * 0.2)
//                Text("Next year, your flight to \(favCity) will cost \(nextYearPrice, specifier: "%.2f")")
//            }
//        }
//        .padding()
//    }
//}



//----------------- CACLC -----------------
//struct ContentView: View{
//    
//    
//    @State var billAmountUI: String = ""
//    @State var billTipUI: String = ""
//    
//    @State var billAmountToPay:Double = 0.0
//    @State var tipAmountToPay:Double = 0.0
//    @State var finalAmount: Double = 0.0
//    var body : some View{
//    
//        VStack{
//            Text("Tip Calculator")
//                .font(.title)
//                .fontWeight(.bold)
//            Spacer()
//            Text("Enter bill amount")
//            TextField("", text: $billAmountUI)
//                .padding(10)
//                .border(.gray)
//            Text("Enter the tip amount as decimal (0.12)")
//            TextField("", text: $billTipUI)
//                .padding(10)
//                .border(.gray)
//            
//            Button("Calculate"){
//                if let tip = Double(billTipUI), let bill = Double(billAmountUI){
//                    billAmountToPay = bill
//                    tipAmountToPay = tip * bill
//                    finalAmount = (tipAmountToPay + bill)
//                }else{
//                    finalAmount = -1
//                }
//            }.padding()
//            
//            if(finalAmount == -1){
//                Text("Invalid inputs!").foregroundStyle(.red).font(.system(size: 16, weight:.semibold))
//            }else{
//                Text("Bill Amount: $\(billAmountToPay, specifier: "%.2f")")
//                Text("Tip Amount: $\(tipAmountToPay, specifier: "%.2f")")
//                Text("Final Amount: $\(finalAmount, specifier: "%.2f")")
//            }
//            
//        }.frame(maxWidth: .infinity, maxHeight: 400, alignment: .center)
//            .padding()
//            
//            
//    }
//}

struct ContentView: View{
    @State var darkMode :Bool = false
    
    @State var billAmountUI: String = ""
    
    @State var billAmountToPay:Double = 0.0
    @State var tipAmountToPay:Double = 0.10
    @State var finalAmount: Double = 0.0
    
    var choices = [0.10, 0.15, 0.2]
    var body : some View{
    
        VStack{
            Toggle("Dark Mode ?", isOn: $darkMode)
            Text("Tip Calculator")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Text("Enter bill amount")
            TextField("", text: $billAmountUI)
                .padding(10)
                .border(.gray)
                .cornerRadius(2)
            Text("Select a tip Amount")
            Picker("Select a tip amount", selection: $tipAmountToPay) {
                ForEach(choices, id: \.self) { choice in
                    Text("\(Int(choice * 100))%").tag(choice)
                }
            }
            .pickerStyle(.segmented)
            
            
            Button("Calculate"){
                if let bill = Double(billAmountUI){
                    billAmountToPay = bill
                    finalAmount = ((tipAmountToPay*bill) + bill)
                }else{
                    finalAmount = -1
                }
            }.padding()
            
            if(finalAmount == -1){
                Text("Invalid inputs!").foregroundStyle(.red).font(.system(size: 26, weight:.semibold))
            }else{
                Text("Bill Amount: $\(billAmountToPay, specifier: "%.2f")")
                Text("Tip Amount: $\(tipAmountToPay, specifier: "%.2f")")
                Text("Final Amount: $\(finalAmount, specifier: "%.2f")")
            }
            
           
        }
        .frame(maxWidth: .infinity, maxHeight: 400, alignment: .center)
            .padding()
            .background(Color(darkMode ? .black: .white))
            .foregroundStyle(Color(darkMode ? .white: .black))
            
            
    }
}

#Preview {
    ContentView()
}
