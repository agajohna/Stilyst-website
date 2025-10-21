//
//  ProviderDashboardView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI
import FirebaseAuth

struct ProviderDashboardView: View {
    @StateObject private var authService = PhoneAuthService()
    @State private var showingProfileEditor = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 16) {
                        HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome back!")
                                .font(.stilystTitle2)
                                .fontWeight(.bold)
                                .foregroundColor(.stilystText)
                            
                            Text("Manage your business on Stilyst")
                                .font(.stilystSubheadline)
                                .foregroundColor(.stilystSecondaryText)
                            
                            // Service category badge
                            HStack {
                                Image(systemName: "scissors")
                                    .font(.caption)
                                    .foregroundColor(.stilystPrimary)
                                Text("Men's Hairstyles Provider")
                                    .font(.stilystCaption)
                                    .foregroundColor(.stilystPrimary)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.stilystPrimary.opacity(0.1))
                            .cornerRadius(8)
                        }
                            
                            Spacer()
                            
                            // Profile image placeholder
                            Circle()
                                .fill(Color.stilystPrimary.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.title2)
                                        .foregroundColor(.stilystPrimary)
                                )
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Stats Cards
                    HStack(spacing: 16) {
                        StatCard(
                            title: "Bookings",
                            value: "12",
                            subtitle: "This month",
                            icon: "calendar",
                            color: .stilystPrimary
                        )
                        
                        StatCard(
                            title: "Earnings",
                            value: "$480",
                            subtitle: "This month",
                            icon: "dollarsign.circle",
                            color: .green
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Actions")
                            .font(.stilystHeadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.stilystText)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            QuickActionButton(
                                title: "View Bookings",
                                subtitle: "Manage your appointments",
                                icon: "calendar.badge.clock",
                                color: .stilystPrimary
                            ) {
                                // TODO: Navigate to bookings
                            }
                            
                            QuickActionButton(
                                title: "Edit Profile",
                                subtitle: "Update your information",
                                icon: "person.circle",
                                color: .blue
                            ) {
                                showingProfileEditor = true
                            }
                            
                            QuickActionButton(
                                title: "Add Portfolio",
                                subtitle: "Showcase your work",
                                icon: "photo.on.rectangle",
                                color: .purple
                            ) {
                                // TODO: Navigate to portfolio editor
                            }
                            
                            QuickActionButton(
                                title: "View Analytics",
                                subtitle: "Track your performance",
                                icon: "chart.bar",
                                color: .orange
                            ) {
                                // TODO: Navigate to analytics
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Recent Activity
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Activity")
                            .font(.stilystHeadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.stilystText)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            ActivityItem(
                                title: "New booking request",
                                subtitle: "Classic Fade - Tomorrow 2:00 PM",
                                time: "2 hours ago",
                                type: .booking
                            )
                            
                            ActivityItem(
                                title: "5-star review received",
                                subtitle: "Great service! Will definitely come back.",
                                time: "1 day ago",
                                type: .review
                            )
                            
                            ActivityItem(
                                title: "Portfolio view",
                                subtitle: "Someone viewed your Textured Crop work",
                                time: "2 days ago",
                                type: .view
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        authService.signOut()
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.stilystPrimary)
                    }
                }
            }
        }
        .sheet(isPresented: $showingProfileEditor) {
            ProviderProfileEditorView()
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.stilystTitle2)
                    .fontWeight(.bold)
                    .foregroundColor(.stilystText)
                
                Text(title)
                    .font(.stilystCaption)
                    .foregroundColor(.stilystSecondaryText)
                
                Text(subtitle)
                    .font(.stilystCaption2)
                    .foregroundColor(.stilystSecondaryText)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.stilystSurface)
        .cornerRadius(16)
        .shadow(color: .stilystShadow, radius: 4, x: 0, y: 2)
    }
}

struct QuickActionButton: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.stilystCallout)
                        .fontWeight(.semibold)
                        .foregroundColor(.stilystText)
                    
                    Text(subtitle)
                        .font(.stilystCaption)
                        .foregroundColor(.stilystSecondaryText)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.stilystSecondaryText)
            }
            .padding(16)
            .background(Color.stilystSurface)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.stilystBorder, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ActivityItem: View {
    let title: String
    let subtitle: String
    let time: String
    let type: ActivityType
    
    enum ActivityType {
        case booking, review, view
        
        var color: Color {
            switch self {
            case .booking: return .stilystPrimary
            case .review: return .green
            case .view: return .blue
            }
        }
        
        var icon: String {
            switch self {
            case .booking: return "calendar.badge.plus"
            case .review: return "star.fill"
            case .view: return "eye.fill"
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(type.color.opacity(0.1))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: type.icon)
                        .font(.caption)
                        .foregroundColor(type.color)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.stilystCallout)
                    .fontWeight(.medium)
                    .foregroundColor(.stilystText)
                
                Text(subtitle)
                    .font(.stilystCaption)
                    .foregroundColor(.stilystSecondaryText)
            }
            
            Spacer()
            
            Text(time)
                .font(.stilystCaption2)
                .foregroundColor(.stilystSecondaryText)
        }
        .padding(12)
        .background(Color.stilystSurface)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.stilystBorder.opacity(0.5), lineWidth: 1)
        )
    }
}

struct ProviderProfileEditorView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile Editor")
                    .font(.stilystTitle2)
                    .fontWeight(.bold)
                
                Text("Coming soon...")
                    .font(.stilystBody)
                    .foregroundColor(.stilystSecondaryText)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ProviderDashboardView()
}
