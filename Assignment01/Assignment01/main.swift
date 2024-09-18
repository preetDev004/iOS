//
//  main.swift
//  Assignment01
//
//  Created by Preet Patel on 17/09/24.
//

import Foundation

class Customer{
    let name : String
    let email : String // when customer sign-up the email can't be changed
    var city : String // May change on long-time
    var creditCard : Int? // Customer can change the credit card later
    var description : CustomStringConvertible{
        // if any detail of the customer is updated the description also gets updated
        get{
            return "Name: \(name)\nEmail: \(email)\nCity: \(city)\nCredit Card: \(creditCard != nil ? "\(creditCard!)\n" : "No credit card provided.")"
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

class RoomReservation{
    let customer : Customer // Reservation is only done by one customer not-changeable
    let dailyRate : Double // reservation is booked on a fix daily rate
    let numOfDays : Int // num if days for the reservation is also fixed
    let taxRate : Double // Does not change for a reservation once fixed  }
    var roomCost : Double{
        get{
            return dailyRate * Double(numOfDays)
        }
    }
    var occupancyTax : Double{
        get{
            return roomCost * taxRate * 0.01
        }
    }
    var total : Double {
        get{
            return roomCost + occupancyTax
        }
    }
    
    init(customer: Customer, dailyRate: Double, numOfDays: Int) {
        self.customer = customer
        self.dailyRate = dailyRate
        self.numOfDays = numOfDays
        self.taxRate = (self.customer.city == "New York City" ? 5.875: 2)
    }
    
    func printInvoice(){
        print("===================")
        print("===== INVOICE =====")
        print("===================")
        print("---Customer Details---")
        print(self.customer.description)
        print("---Room Details---")
        print("Daily Rate: $\(self.dailyRate)")
        print("Length of stay: \(self.numOfDays) days")
        print("Subtotal: $\(self.roomCost)")
        print("Tax (\(self.taxRate)%): $\(self.occupancyTax)")
        print("Total: $\(self.total)")
    }
    
}

class ConferenceRoomReservation : RoomReservation{
    
}


var c1 = Customer(name: "Preet", city: "Delhi")
var c2 = Customer(name: "Maddy", email: "maddy@gmail.com", city: "Mumbai", creditCard: 1234)

var res1 = RoomReservation(customer: c1, dailyRate: 341.5, numOfDays: 3)

res1.printInvoice()
