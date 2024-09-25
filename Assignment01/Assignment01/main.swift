//  main.swift
//  Assignment01
//  Created by Preet Patel on 17/09/24.
import Foundation

// Customer Class
class Customer : CustomStringConvertible{
    let name : String
    let email : String // when customer sign-up the email can't be changed
    var city : String // May change on long-time
    var creditCard : Int? = nil // Customer can change the credit card later
    var description : String{
        // if any detail of the customer is updated the description also gets updated
        get{
            return "Name: \(name)\nEmail: \(email)\nCity: \(city)\nCredit Card: \(creditCard != nil ? "\(creditCard!)" : "No credit card provided.")"
        }
    }
    init(name: String, city: String, creditCard: Int?) {
        self.name = name
        self.email = self.name.lowercased() + "@gmail.com"
        self.city = city
        self.creditCard = creditCard
    }
    init(name: String, city: String) {
        self.name = name
        self.email = self.name.lowercased() + "@gmail.com"
        self.city = city
    }
}

// RoomReservation Class
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
        self.taxRate = self.customer.city == "New York City" ? 5.875 : 2
    }
    
    func printInvoice(){
        print("===================")
        print("===== INVOICE =====")
        print("===================")
        print("---Customer Details---")
        print(self.customer)
        print("---Room Details---")
        print("Daily Rate: $\(self.dailyRate)")
        print("Length of stay: \(self.numOfDays) days")
        print("Subtotal: $\(self.roomCost)")
        print("Tax (\(self.taxRate)%): $\(self.occupancyTax)")
        print("Total: $\(self.total)\n")
    }
    
}

// ConferenceRoomReservation Class
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
        if self.additionalServices[serviceName] != nil{
            print("\(serviceName) already exists in the list of services!\n")
            return
        }
        self.additionalServices[serviceName] = cost
        print("\(serviceName) added to the list of services!\n")
    }
    override func printInvoice(){
        print("===================")
        print("===== INVOICE =====")
        print("===================")
        print("---Customer Details---")
        print(self.customer)
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

// Testing the Classes:
var customer1 = Customer(name: "Preet", city: "Mumbai")
var customer2 = Customer(name: "Maddy", city: "New York City", creditCard: 1001)

var roomReservation = RoomReservation(customer: customer2, dailyRate: 132.50, numOfDays: 4)

var services : [String: Double] = ["Catering" : 2150, "Power Banks": 950.78, "A/V Equipments": 521.43]
var confRoomReservation = ConferenceRoomReservation(customer: customer1, eventName: "Hack The North",
                                                 numOfAttendees: 72, numOfDays: 3, additionalServices: services)
roomReservation.printInvoice()

confRoomReservation.addService(serviceName: "Power Banks", cost: 870.56)

confRoomReservation.printInvoice()
