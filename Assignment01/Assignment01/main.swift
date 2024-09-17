//
//  main.swift
//  Assignment01
//
//  Created by Preet Patel on 17/09/24.
//

import Foundation

class Customer{
    let name : String
    var email : String // when customer sign-up the email is assigned and can be changed
    var city : String // May change on long-time
    var creditCard : Int? // Customer can change the credit card later
    var description : CustomStringConvertible{
        get{
            return "Name: \(name)\nEmail: \(email)\nCity: \(city)\nCredit Card: \(creditCard != nil ? "\(creditCard!)\n" : "No credit card provided.")\n"
        }
    }
    //TODO: ASK PROF ABOUT ONE CONSTRUCTOR OVER MULTIPTIPLE
    // Giving default values for email and credit card!
    init(name: String, email: String = "name@gmail.com", city: String, creditCard: Int? = nil) {
        self.name = name
        self.email = email
        self.city = city
        self.creditCard = creditCard
    }
    
    
}
//var c1 = Customer(name: "Preet", city: "Delhi")
//var c2 = Customer(name: "Maddy", email: "maddy@gmail.com", city: "Mumbai", creditCard: 1234)
//
//print(c1.description)
//print(c2.description)

class RoomReservation{
    
}
class ConferenceRoomReservation : RoomReservation{
    
}
