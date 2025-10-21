//
//  UserProfileView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    @ObservedObject var authService: PhoneAuthService
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSignOutAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 16) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.stilystPrimary.opacity(0.3), Color.stilystPrimary.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.stilystPrimary)
                            )
                        
                        VStack(spacing: 4) {
                            Text("User Profile")
                                .font(.stilystTitle2)
                                .fontWeight(.bold)
                                .foregroundColor(.stilystText)
                            
                            if let email = authService.user?.email {
                                Text(email)
                                    .font(.stilystBody)
                                    .foregroundColor(.stilystSecondaryText)
                            } else if let phone = authService.user?.phoneNumber {
                                Text(phone)
                                    .font(.stilystBody)
                                    .foregroundColor(.stilystSecondaryText)
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                    // Account Info
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Account Information")
                            .font(.stilystHeadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.stilystText)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            InfoRow(
                                icon: "person.circle",
                                title: "User ID",
                                value: String(authService.user?.uid.prefix(8) ?? "") + "..."
                            )
                            
                            InfoRow(
                                icon: "envelope.circle",
                                title: "Email",
                                value: authService.user?.email ?? "Not provided"
                            )
                            
                            InfoRow(
                                icon: "phone.circle",
                                title: "Phone",
                                value: authService.user?.phoneNumber ?? "Not provided"
                            )
                            
                            InfoRow(
                                icon: "calendar.circle",
                                title: "Account Type",
                                value: UserDefaults.standard.bool(forKey: "hasCompletedProviderOnboarding") ? "Provider" : "Customer"
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                    // Actions
                    VStack(spacing: 16) {
                        // Sign Out Button
                        Button(action: {
                            showingSignOutAlert = true
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.title3)
                                Text("Sign Out")
                                    .font(.stilystButton)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.stilystPrimary)
                }
            }
            .alert("Sign Out", isPresented: $showingSignOutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive) {
                    authService.signOut()
                    // Clear provider status
                    UserDefaults.standard.set(false, forKey: "hasCompletedProviderOnboarding")
                    presentationMode.wrappedValue.dismiss()
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.stilystPrimary)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.stilystCaption)
                    .foregroundColor(.stilystSecondaryText)
                
                Text(value)
                    .font(.stilystCallout)
                    .foregroundColor(.stilystText)
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.stilystSurface)
        .cornerRadius(12)
    }
}

#Preview {
    UserProfileView(authService: PhoneAuthService())
}

