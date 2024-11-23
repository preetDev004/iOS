//
//  Student.swift
//  w11-Firebase
//
//  Created by Preet Patel on 20/11/24.
//
import Foundation
import FirebaseFirestore

struct Student : Codable, Identifiable{
    @DocumentID
    var id: String?
    
    var name: String
    var gpa:Double
    var isDiplomaLevel:Bool
}
