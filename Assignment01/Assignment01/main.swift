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
            return "Name: \(name)\nEmail: \(email)\nCity: \(city)\nCredit Card: \(creditCard != nil ? "\(creditCard!)" : "No credit card provided.")"
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
    var numOfDays : Int // num if days for the reservation is also fixed
    let taxRate : Double // Does not change for a reservation once fixed  }
    var roomCost : Double{
        get{
            return self.dailyRate * Double(self.numOfDays)
        }
    }
    var occupancyTax : Double{
        get{
            return self.roomCost * self.taxRate * 0.01
        }
    }
    var total : Double {
        get{
            return self.roomCost + self.occupancyTax
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
        print("Total: $\(self.total)\n")
    }
    
}

class ConferenceRoomReservation : RoomReservation{
    let eventName : String
    let numOfAttendees : Int
    var additionalServices : [String : Double]
    override var total: Double{
        get{
            var costOfServices: Double = 0
            for (_, cost) in additionalServices{
                costOfServices += cost
            }
            return (super.roomCost * Double(self.numOfAttendees)) + super.occupancyTax + costOfServices
        }
    }
    
    init(customer: Customer, eventName: String, numOfAttendees: Int, numOfDays: Int, additionalServices: [String : Double]) {
        self.eventName = eventName
        self.numOfAttendees = numOfAttendees
        self.additionalServices = additionalServices
        super.init(customer: customer, dailyRate: 105, numOfDays: numOfDays)
    }
    
    func addService(serviceName: String, cost : Double){
        if self.additionalServices[serviceName] == nil{
            self.additionalServices[serviceName] = cost
        }
       
    }
    override func printInvoice(){
        print("===================")
        print("===== INVOICE =====")
        print("===================")
        print("---Customer Details---")
        print(self.customer.description)
        print("---Event Details---")
        print("Event Name: \(self.eventName)")
        print("Length \(self.numOfDays) days")
        print("Atendees: \(self.numOfAttendees)")
        print("Room Cost: $\(self.roomCost * Double(self.numOfAttendees))")
        print("Occupancy Tax (\(self.taxRate)%): $\(self.occupancyTax * Double(self.numOfAttendees))")
        print("Additional Services:")
        for (service, cost) in self.additionalServices{
            print(" + \(service): $\(cost)")
        }
        print("Total: $\(self.total)\n")
    }
    
}


var c1 = Customer(name: "Preet", city: "Delhi")
var c2 = Customer(name: "Maddy", email: "maddy@gmail.com", city: "Mumbai", creditCard: 1234)
var c3 = Customer(name: "Kabir", email: "kbir@gmail.com", city: "New York City", creditCard: 1001)

//var res1 = RoomReservation(customer: c1, dailyRate: 341.5, numOfDays: 3)
//res1.printInvoice()
var services : [String : Double] = ["Catering" : 1375.99, "A/V Equipment": 250.0,  "Printing Services": 80.5]
var cRes1 = ConferenceRoomReservation(customer: c3, eventName: "Toronto Anime Festival", numOfAttendees: 35, numOfDays: 2, additionalServices: services)
cRes1.printInvoice()

cRes1.addService(serviceName: "Pedicure", cost: 1200)
cRes1.printInvoice()
