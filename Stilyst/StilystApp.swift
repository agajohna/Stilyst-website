//
//  StilystApp.swift
//  Stilyst
//
//  Created by Aren Agajohn on 10/21/25.
//

import SwiftUI
import FirebaseCore

@main
struct StilystApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
