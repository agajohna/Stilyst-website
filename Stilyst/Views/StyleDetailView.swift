//
//  StyleDetailView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI

struct StyleDetailView: View {
    let style: Style
    @StateObject private var viewModel = StyleDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Hero image
                AsyncImage(url: URL(string: style.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay {
                            ProgressView()
                        }
                }
                .frame(height: 400)
                .clipped()
                
                VStack(alignment: .leading, spacing: 16) {
                    // Style name and description
                    VStack(alignment: .leading, spacing: 8) {
                        Text(style.name)
                            .font(.stilystTitle2)
                            .fontWeight(.bold)
                            .foregroundColor(.stilystText)
                        
                        Text(style.description)
                            .font(.stilystBody)
                            .foregroundColor(.stilystSecondary)
                    }
                    
                    // Tags
                    if !style.tags.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(style.tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .cornerRadius(16)
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    // CTA Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Find Specialists")
                            .font(.stilystHeadline)
                            .fontWeight(.bold)
                            .foregroundColor(.stilystText)
                        
                        Text("\(viewModel.providers.count) specialists near you can do this style")
                            .font(.stilystSubheadline)
                            .foregroundColor(.stilystSecondary)
                        
                        NavigationLink(value: style.id) {
                            HStack {
                                Text("View All Specialists")
                                    .font(.stilystButton)
                                Spacer()
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.stilystPrimary)
                            .cornerRadius(16)
                        }
                    }
                    
                    Divider()
                    
                    // Preview of top specialists
                    if !viewModel.providers.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Top Specialists")
                                .font(.stilystHeadline)
                                .foregroundColor(.stilystText)
                            
                            ForEach(viewModel.providers.prefix(3)) { provider in
                                ProviderRow(provider: provider, styleId: style.id)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: String.self) { styleId in
            ProviderListView(styleId: styleId)
        }
        .onAppear {
            viewModel.loadProviders(for: style.id)
        }
    }
}

struct ProviderRow: View {
    let provider: Provider
    let styleId: String
    
    var portfolioForStyle: [PortfolioImage] {
        provider.portfolioImages.filter { $0.styleId == styleId }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile image
            AsyncImage(url: URL(string: provider.profileImageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(provider.name)
                    .font(.headline)
                
                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                        Text(String(format: "%.1f", provider.rating))
                            .font(.subheadline)
                    }
                    .foregroundColor(.orange)
                    
                    Text("(\(provider.reviewCount))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(provider.priceRange)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text(provider.businessName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Portfolio preview
            if let firstImage = portfolioForStyle.first {
                AsyncImage(url: URL(string: firstImage.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.stilystSurface)
        .cornerRadius(16)
        .shadow(color: .stilystShadow, radius: 4, x: 0, y: 2)
    }
}

class StyleDetailViewModel: ObservableObject {
    @Published var providers: [Provider] = []
    @Published var isLoading = false
    
    private let providerService = ProviderCollection()
    
    func loadProviders(for styleId: String) {
        isLoading = true
        providerService.fetchProviders(for: styleId) { [weak self] fetchedProviders in
            DispatchQueue.main.async {
                self?.providers = fetchedProviders
                self?.isLoading = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        StyleDetailView(style: MockData.styles[0])
    }
}

