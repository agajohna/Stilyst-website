//
//  StylesFeedView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI

struct StylesFeedView: View {
    let category: ServiceCategory
    @StateObject private var viewModel = StylesFeedViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.styles) { style in
                    NavigationLink(value: style) {
                        StyleCard(style: style)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(category.rawValue)
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(for: Style.self) { style in
            StyleDetailView(style: style)
        }
        .background(Color.stilystBackground)
        .onAppear {
            viewModel.loadStyles(for: category)
        }
    }
}

struct StyleCard: View {
    let style: Style
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Style image
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
            .frame(height: 200)
            .clipped()
            .cornerRadius(12)
            .overlay(alignment: .topTrailing) {
                if style.trending {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.caption2)
                        Text("Trending")
                            .font(.caption2)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .padding(8)
                }
            }
            
            // Style name
            Text(style.name)
                .font(.stilystCallout)
                .fontWeight(.medium)
                .foregroundColor(.stilystText)
                .lineLimit(2)
            
            // Metrics
            HStack(spacing: 12) {
                Label("\(style.viewCount)", systemImage: "eye.fill")
                    .font(.stilystCaption)
                    .foregroundColor(.stilystSecondary)
                
                Label("\(style.bookingCount)", systemImage: "calendar")
                    .font(.stilystCaption)
                    .foregroundColor(.stilystSecondary)
            }
        }
        .background(Color.stilystSurface)
        .cornerRadius(16)
        .shadow(color: .stilystShadow, radius: 4, x: 0, y: 2)
    }
}

// ViewModel for managing styles data
class StylesFeedViewModel: ObservableObject {
    @Published var styles: [Style] = []
    @Published var isLoading = false
    
    private let styleService = StyleService()
    
    func loadStyles(for category: ServiceCategory) {
        isLoading = true
        styleService.fetchStyles(for: category) { [weak self] fetchedStyles in
            DispatchQueue.main.async {
                self?.styles = fetchedStyles
                self?.isLoading = false
            }
        }
    }
    
    func incrementViewCount(for style: Style) {
        guard let styleId = style.id else { return }
        styleService.incrementViewCount(for: styleId)
    }
}

#Preview {
    NavigationStack {
        StylesFeedView(category: .mensHair)
    }
}

