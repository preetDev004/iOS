//
//  WrapUpPracticeApp.swift
//  WrapUpPractice
//
//  Created by Preet Patel on 03/12/24.
//

import SwiftUI
import FirebaseCore

@main
struct WrapUpPracticeApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            AllSongsView()
        }
    }
}
