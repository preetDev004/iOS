//
//  main.swift
//  Session02
//
//  Created by Preet Patel on 05/09/24.
//

import Foundation

print(
    "Hello, World!"
)

let age: Int32 = 21

// Coditional
if (age>=21) {
    print("You are eligible to vote as you are \(age) years old. ")
}
else{
    print("You must wait \(21-age) years to vote")
}


var secondaryColor = "green"

switch secondaryColor {
  case "orange":
    print("A mixture of red and yellow")
  case "purple":
    print("A mix of red and blue")
  default:
    print("This may not be a secondary color")
}
// print: mix of blue and yellow


// loop
for i in 0...4{
    print(i)
}
print("")

var i : Int32 = 0
repeat{
    print(i)
    i+=1
}while(i<4)
print("")
for i in 0..<5{
    print(i)
}

// array
var cities: [String] = ["New York", "Mumbai", "Ahemdabad","New Delhi"]
print(cities.count)
print(cities[cities.count-1])

cities.append("Toronto")
//cities.remove(at: 0)
print(cities.capacity)
print(cities)

for city in cities{
    print(city)
}
//var test : [Any] = [
//    1,2,3,"hi"
//]

// Set - Won't throw error if repeating item occurs, will just omit the first one!
var countries : Set<String> = [
      "The Dream",
      "The Starry Night",
      "The False Mirror",
      "The Dream"
]
print(countries)

// Function
func convertDate(str: String){
    let df = DateFormatter()
    df.dateFormat = "d MMMM yyyy"

    guard let dateOfBirth = df.date(from: str) else {
        print("Provided date is invalid!")
        return
    }
    print(dateOfBirth)

}
convertDate(str: "19 August 2004")

// New
var distance = 5 {
  willSet(newDistance) {
    print("The distance will be set to \(newDistance)")
  }
  didSet {
    print("The distance is set to \(distance)")
    print("Its old value is: \(oldValue)")
  }
}
distance = 10
