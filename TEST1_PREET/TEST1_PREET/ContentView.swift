//
//  ContentView.swift
//  TEST1_PREET
//
//  Created by Preet Patel on 17/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var morningUsageUI : String = ""
    @State var eveningUsageUI : String = ""
    @State var isEnergyRebate : Bool = false
    @State var isReceipt : Bool = false
    
    
    @State var morningUsage: Double = 0.0
    @State var morningCost: Double = 0.0
    @State var eveningUsage: Double = 0.0
    @State var eveningCost: Double = 0.0
    @State var rebateAmount: Double = 0.0
    
    
    @State var totalUsage: Double = 0.0
    @State var totalCost: Double = 0.0
    
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading){
                Text("Electricity Bill Calculator")
                    .font(.system(size: 32))
                
                Text("Enter morning usage:")
                    .font(.system(size: 20))
                TextField("Enter bill amount",text:$morningUsageUI)
                .padding(10)
                .border(Color.black, width: 1)
                Text("Enter morning usage:")
                    .font(.system(size: 20))
                TextField("Enter bill amount",text:$eveningUsageUI)
                    .padding(10)
                    .border(Color.black, width: 1)
                
                HStack{

                    Toggle("Does you qualify for energy rebate?",isOn:$isEnergyRebate)
                }
                
              
                
            }.padding(8)
                
            
            Button("Calculate"){
                if let mUsage = Double(morningUsageUI), let eUsage = Double(eveningUsageUI){
                    
                    isReceipt = true
                    morningCost = mUsage * 0.05
                    eveningCost = eUsage * 0.119
                    totalUsage = mUsage + eUsage
                    totalCost = morningCost + eveningCost
                    rebateAmount = 0
                    if (isEnergyRebate){
                        rebateAmount = totalCost * 0.08
                    }
                }else{
                    isReceipt = false
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
            .background(.black)
            .foregroundStyle(.white)
            .cornerRadius(8)
            Spacer()
            
            if(isReceipt){
            
            VStack{
                HStack{
                    VStack{
                        Text("MORNING COST")
                        Text("$\(morningCost)")
                            .font(.system(size: 26, weight: .bold))
                        Text("\(morningUsageUI) @ $0.05/Kwh")
                    }
                    .padding(16)
                    .background(.pink)
                    .cornerRadius(8)
                    
                    VStack{
                        
                        Text("EVENING COST")
                        Text("$\(eveningCost)")
                            .font(.system(size: 26, weight: .bold))
                        Text("\(eveningUsageUI) @ $0.119/Kwh")
                    }
                    .frame(width: 155)
                    .padding(16)
                    .background(.cyan)
                    .cornerRadius(8)
                }
                Text("Usage Charges: $\(morningCost + eveningCost)")
                    .font(.system(size: 20))
                Text("Sales Tax (13%): $\(totalCost * 0.13)")
                    .font(.system(size: 20))
                Text("Energy Rebate: $\(rebateAmount)")
                    .font(.system(size: 20))
                
                VStack{
                    
                    Text("YOU MUST PAY")
                    Text("$\((morningCost + eveningCost) + (totalCost * 0.13) - rebateAmount)")
                        .font(.system(size: 46, weight: .bold))
                }
                .padding(18)
                .foregroundStyle(.white)
                .background(.gray)
                .cornerRadius(8)
                
            }
            }
            
        }
        .padding()

    }
}

#Preview {
    ContentView()
}
