//
//  main.swift
//  Session01
//
//  Created by Preet Patel on 03/09/24.
//

import Foundation

struct Person{
    var name: String
    var age :Int32
    
    mutating func setName(name : String){
        self.name = name
    }
     func getName() -> String{
        return self.name
    }
}
print("Hello, World!")
let u :String = "Hi"



func main(){
    var per1 = Person(name: "preet", age: 20)
    per1.setName(name: "maddy")
    print("Hi the name is changed to \(per1.getName())")
    print(type(of: u))
    print(type(of: per1))
}
main()
