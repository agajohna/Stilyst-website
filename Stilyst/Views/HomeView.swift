//
//  HomeView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedCategory: ServiceCategory?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Stilyst")
                            .font(.system(size: 36, weight: .bold))
                        Text("Discover your next look. Book it instantly.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Category Grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(ServiceCategory.allCases) { category in
                            NavigationLink(value: category) {
                                CategoryCard(category: category)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationDestination(for: ServiceCategory.self) { category in
                StylesFeedView(category: category)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct CategoryCard: View {
    let category: ServiceCategory
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                // Gradient background
                LinearGradient(
                    colors: category.gradient.map { Color(hex: $0) },
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Icon
                Image(systemName: category.icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            .frame(height: 140)
            .cornerRadius(16)
            
            Text(category.rawValue)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

// Color extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    HomeView()
}

