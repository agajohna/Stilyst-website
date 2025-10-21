//
//  ProviderListView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI

struct ProviderListView: View {
    let styleId: String
    @StateObject private var viewModel = ProviderListViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.providers) { provider in
                    NavigationLink(destination: ProviderDetailView(provider: provider, styleId: styleId)) {
                        ProviderCard(provider: provider, styleId: styleId)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .navigationTitle("Specialists")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
        .onAppear {
            viewModel.loadProviders(for: styleId)
        }
    }
}

struct ProviderCard: View {
    let provider: Provider
    let styleId: String
    
    var portfolioForStyle: [PortfolioImage] {
        provider.portfolioImages.filter { $0.styleId == styleId }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with profile
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: provider.profileImageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(provider.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(provider.businessName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 8) {
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                            Text(String(format: "%.1f", provider.rating))
                                .font(.subheadline)
                        }
                        .foregroundColor(.orange)
                        
                        Text("(\(provider.reviewCount) reviews)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(provider.priceRange)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
                
                Spacer()
            }
            
            // Portfolio for this style
            if !portfolioForStyle.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Work in this style")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(portfolioForStyle) { image in
                                AsyncImage(url: URL(string: image.imageURL)) { img in
                                    img
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                }
                                .frame(width: 120, height: 120)
                                .cornerRadius(12)
                            }
                        }
                    }
                }
            }
            
            // Location
            HStack {
                Image(systemName: "location.fill")
                    .font(.caption)
                Text(provider.location.city + ", " + provider.location.state)
                    .font(.caption)
            }
            .foregroundColor(.secondary)
            
            // Book button
            HStack {
                Image(systemName: "calendar")
                Text("View Schedule & Book")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(12)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

struct ProviderDetailView: View {
    let provider: Provider
    let styleId: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Profile header
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: provider.profileImageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    
                    VStack(spacing: 8) {
                        Text(provider.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(provider.businessName)
                            .font(.title3)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 4) {
                            ForEach(0..<5) { index in
                                Image(systemName: index < Int(provider.rating) ? "star.fill" : "star")
                                    .foregroundColor(.orange)
                            }
                            Text(String(format: "%.1f", provider.rating))
                                .fontWeight(.semibold)
                            Text("(\(provider.reviewCount) reviews)")
                                .foregroundColor(.secondary)
                        }
                        .font(.subheadline)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Divider()
                
                // Bio
                VStack(alignment: .leading, spacing: 8) {
                    Text("About")
                        .font(.headline)
                    Text(provider.bio)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // Location
                VStack(alignment: .leading, spacing: 8) {
                    Text("Location")
                        .font(.headline)
                    HStack {
                        Image(systemName: "location.fill")
                        Text(provider.location.address)
                    }
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Divider()
                
                // TODO: Calendar/availability integration
                VStack(alignment: .leading, spacing: 12) {
                    Text("Book Appointment")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text("Calendar integration coming soon")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    Button(action: {
                        // TODO: Booking flow
                    }) {
                        Text("Select Date & Time")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

class ProviderListViewModel: ObservableObject {
    @Published var providers: [Provider] = []
    
    func loadProviders(for styleId: String) {
        // TODO: Load from Firebase
        providers = MockData.providers.filter { $0.specialties.contains(styleId) }
            .sorted { $0.rating > $1.rating }
    }
}

#Preview {
    NavigationStack {
        ProviderListView(styleId: "style1")
    }
}

