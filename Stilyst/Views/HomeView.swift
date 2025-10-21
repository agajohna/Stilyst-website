//
//  HomeView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//  Following Apple Human Interface Guidelines
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var selectedCategory: ServiceCategory?
    @State private var showingProviderOnboarding = false
    @State private var showingProfile = false
    @StateObject private var authService = PhoneAuthService()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) { // Apple HIG: 32pt spacing for sections
                    // Header with tagline only
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Discover your look. Book your stylist.")
                            .font(.stilystTitle2)
                            .fontWeight(.bold)
                            .foregroundColor(.stilystText)
                            .multilineTextAlignment(.leading)
                        
                        // Subtle divider line with gradient
                        LinearGradient(
                            colors: [
                                Color.clear,
                                Color.stilystBorder,
                                Color.clear
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(height: 1)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Category Grid - Following Apple HIG spacing principles
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(ServiceCategory.allCases) { category in
                            NavigationLink(value: category) {
                                CategoryCard(category: category)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(PlainButtonStyle()) // Apple HIG: Remove default button styling
                        }
                    }
                    .padding(.horizontal, 20) // Apple HIG: 20pt horizontal padding
                    
                    // Provider Onboarding Button
                    VStack(spacing: 12) {
                        Text("Are you a barber or stylist?")
                            .font(.stilystSubheadline)
                            .foregroundColor(.stilystSecondaryText)
                        
                        Button(action: {
                            showingProviderOnboarding = true
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "scissors")
                                    .font(.stilystCallout)
                                Text("Join as a Provider")
                                    .font(.stilystButton)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            .background(Color.stilystPrimary)
                            .cornerRadius(25)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 20) // Apple HIG: 20pt vertical padding
            }
            .navigationDestination(for: ServiceCategory.self) { category in
                StylesFeedView(category: category)
            }
            .sheet(isPresented: $showingProviderOnboarding) {
                ProviderOnboardingView()
            }
            .background(Color.stilystBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .cornerRadius(6)
                        
                        Text("Stilyst")
                            .font(.stilystNavigationBarTitle)
                            .foregroundColor(.stilystText)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let user = authService.user {
                        Button(action: {
                            showingProfile = true
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "person.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(.stilystPrimary)
                                
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("Signed In")
                                        .font(.stilystCaption2)
                                        .foregroundColor(.stilystSecondaryText)
                                }
                            }
                        }
                        .sheet(isPresented: $showingProfile) {
                            UserProfileView(authService: authService)
                        }
                    }
                }
            }
            .onAppear {
                authService.checkAuthState()
            }
        }
    }
}

struct CategoryCard: View {
    let category: ServiceCategory
    
    var body: some View {
        VStack(spacing: 0) {
            // Main card with gradient background
            ZStack {
                // Sophisticated gradient background
                LinearGradient(
                    colors: [
                        Color.stilystSurface,
                        Color.stilystPrimary.opacity(0.05)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Icon with enhanced styling
                Image(systemName: category.icon)
                    .font(.system(size: 32, weight: .light))
                    .foregroundColor(.stilystPrimary)
                    .shadow(color: .stilystPrimary.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .frame(height: 140)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.stilystBorder,
                                Color.stilystPrimary.opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: .stilystShadow, radius: 12, x: 0, y: 6)
            
            // Category name with enhanced typography
            VStack(spacing: 4) {
                Text(category.rawValue)
                    .font(.stilystHeadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.stilystText)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                // Subtle accent line
                Rectangle()
                    .fill(Color.stilystPrimary)
                    .frame(width: 30, height: 2)
                    .cornerRadius(1)
            }
            .padding(.top, 12)
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    HomeView()
}

