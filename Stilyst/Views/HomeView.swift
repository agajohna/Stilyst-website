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
                            .font(.stilystTitle)
                            .foregroundColor(.stilystText)
                        Text("The style you want. The pros who do it.")
                            .font(.stilystSubheadline)
                            .foregroundColor(.stilystSecondary)
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
            .background(Color.stilystBackground)
        }
    }
}

struct CategoryCard: View {
    let category: ServiceCategory
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                // Minimalist background with subtle gradient
                LinearGradient(
                    colors: [Color.stilystSurface, Color.stilystSecondary.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Icon with brand styling
                Image(systemName: category.icon)
                    .font(.system(size: 32, weight: .light))
                    .foregroundColor(.stilystText)
            }
            .frame(height: 140)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.stilystBorder, lineWidth: 1)
            )
            .shadow(color: .stilystShadow, radius: 8, x: 0, y: 4)
            
            Text(category.rawValue)
                .font(.stilystCallout)
                .foregroundColor(.stilystText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    HomeView()
}

