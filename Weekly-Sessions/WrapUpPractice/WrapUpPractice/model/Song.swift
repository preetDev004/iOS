//
//  Song.swift
//  WrapUpPractice
//
//  Created by Preet Patel on 03/12/24.
//

import Foundation
import FirebaseFirestore

struct Song : Identifiable, Codable{
    @DocumentID
    var id: String?

    var name: String
    var artist: String
    var genre: String
    var image: String
    var isFav : Bool = false
    
}
