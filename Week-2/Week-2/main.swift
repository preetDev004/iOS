//
//  main.swift
//  Week-2
//
//  Created by Preet Patel on 10/09/24.
//
import Foundation

print("Hello, World!")

var person : [String : String] = [
    "name" : "Preet",
    "age" : "20",
    "DOB" : "!9 Aug 2004",
    "favSport" : "cricket",
    "isMarried" : "No"
]
print(type(of: person))

print(person.count)
print(person.keys)
print(person.isEmpty)
print(person.values)
print(person["DOB"]!)

person.removeValue(forKey: "age")
print(person.hashValue)
person["profession"] = "student"
print(person)


func add(a : Int, b : Int, c: Int, d: Int) -> Int{
    return a+b+c+d
}
func mul(_ a : Int,_ b : Int,_ c: Int,_ d: Int) -> Int{
    return a*b*c*d
}
print(add(a: 4, b: 5, c: 7, d: 2))
print(mul(4, 5, 7, 2))

func sendMoney(_ a: String, _ b: String, _ c:Double){
    print("$\(c) is sent to \(a) by \(b)")
}
func sendMoneyClearly(to: String, from : String, amount :Double){
    print("$\(amount) is sent to \(to) by \(from)")
}

sendMoney("Preet", "Maddy", 1201)
sendMoneyClearly(to: "Maddy", from: "Preet", amount: 1200.50)
