//
//  w11_FirebaseApp.swift
//  w11-Firebase
//
//  Created by Preet Patel on 20/11/24.
//

import SwiftUI
import FirebaseCore

@main
struct w11_FirebaseApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
