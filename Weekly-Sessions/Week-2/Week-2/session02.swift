//
//  session02.swift
//  Week-2
//
//  Created by Preet Patel on 12/09/24.
//

import Foundation

// 1. stored propeties class
class Car{
    // var model: String = nil -> does not allow sto set Nil as its a own type --> will work now var model: String? = nil
    var model: String
    var speed: Int
//    private var price: Double
    
    
    // Initializer | Constructor
    init(){
        self.model = "BMW x7"
        self.speed = 50
        
    }
    // Custom initializer
    init(model: String, speed: Int) {
        self.model = model
        self.speed = speed
    }
    
    func accelerate(){
        self.speed += 10
    }
    func brake(){
        self.speed = 0
    }
}

// 2. Computed properties class --> Solved all the getter and Private var problems when the properties are computed or                                       depend on other property.
class Circle{
     var radius : Double
     var diameter : Double{
         return self.radius * self.radius * Double.pi
    }
    var area : Double{
        get{
            return self.radius * 2
        }
    }
    init(radius: Double) {
        self.radius = radius
    }
   
}
