//
//  ContentView.swift
//  Stilyst
//
//  Created by Aren Agajohn on 10/21/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject private var authService = PhoneAuthService()
    @State private var isProvider = false
    @State private var showingOnboarding = false
    
    var body: some View {
        Group {
            if authService.user != nil {
                if isProvider {
                    ProviderDashboardView()
                } else {
                    HomeView()
                }
            } else {
                HomeView()
            }
        }
        .onAppear {
            authService.checkAuthState()
            checkUserType()
        }
        .onChange(of: authService.user) { _, newUser in
            if newUser != nil {
                checkUserType()
            } else {
                isProvider = false
            }
        }
        .sheet(isPresented: $showingOnboarding) {
            ProviderOnboardingView()
        }
    }
    
    private func checkUserType() {
        // For now, we'll assume any authenticated user who just completed onboarding is a provider
        // In a real app, you'd check the user's role in Firestore
        if authService.user != nil {
            // Check if user just completed onboarding (you could store this in UserDefaults or Firestore)
            let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedProviderOnboarding")
            isProvider = hasCompletedOnboarding
            print("👤 Checking user type - isProvider: \(isProvider), hasCompletedOnboarding: \(hasCompletedOnboarding)")
        }
    }
}

#Preview {
    ContentView()
}
