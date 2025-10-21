//
//  StilystApp.swift
//  Stilyst
//
//  Created by Aren Agajohn on 10/21/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct StilystApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
