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
    @StateObject private var locationService = LocationService.shared
    @State private var selectedLocation = "Near You"
    @State private var showingLocationPicker = false
    
    
    let popularCities = [
        "Near You",
        "Los Angeles, CA",
        "New York, NY", 
        "Copenhagen, Denmark",
        "London, UK",
        "Tokyo, Japan",
        "Sydney, Australia",
        "Paris, France"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Location Picker Header
            VStack(spacing: 12) {
                HStack {
                    Text("Trending in")
                        .font(.stilystSubheadline)
                        .foregroundColor(.stilystSecondaryText)
                    
                    Spacer()
                    
                    Button(action: {
                        showingLocationPicker = true
                    }) {
                        HStack(spacing: 4) {
                            Text(selectedLocation)
                                .font(.stilystCallout)
                                .fontWeight(.medium)
                                .foregroundColor(.stilystPrimary)
                            
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundColor(.stilystPrimary)
                        }
                    }
                }
                
                // Location indicator
                if selectedLocation == "Near You" {
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                            .foregroundColor(.stilystPrimary)
                        
                        if locationService.currentLocation != nil {
                            Text("Location enabled")
                                .font(.stilystCaption)
                                .foregroundColor(.stilystSecondaryText)
                        } else {
                            Text("Enable location to see nearby trends")
                                .font(.stilystCaption)
                                .foregroundColor(.stilystSecondaryText)
                        }
                    }
                } else {
                    HStack(spacing: 4) {
                        Image(systemName: "globe")
                            .font(.caption)
                            .foregroundColor(.stilystPrimary)
                        
                        Text("Global inspiration")
                            .font(.stilystCaption)
                            .foregroundColor(.stilystSecondaryText)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.stilystSurface)
            
            // Styles Grid - Following Apple HIG spacing principles
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    ForEach(viewModel.styles) { style in
                        NavigationLink(value: style) {
                            StyleCard(style: style)
                        }
                        .buttonStyle(PlainButtonStyle()) // Apple HIG: Remove default button styling
                    }
                }
                .padding(.horizontal, 20) // Apple HIG: 20pt horizontal padding
                .padding(.vertical, 16)   // Apple HIG: 16pt vertical padding
            }
        }
        .navigationTitle(category.rawValue)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .cornerRadius(4)
            }
        }
        .navigationDestination(for: Style.self) { style in
            StyleDetailView(style: style)
        }
        .background(Color.stilystBackground)
        .onAppear {
            locationService.requestLocationPermission()
            viewModel.loadStyles(for: category, location: selectedLocation)
        }
        .onChange(of: selectedLocation) { _, newLocation in
            viewModel.loadStyles(for: category, location: newLocation)
        }
        .sheet(isPresented: $showingLocationPicker) {
            LocationPickerView(
                selectedLocation: $selectedLocation,
                popularCities: popularCities,
                locationService: locationService
            )
        }
    }
}

struct StyleCard: View {
    let style: Style
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Style image with enhanced styling
            ZStack {
                AsyncImage(url: URL(string: style.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.stilystBorder.opacity(0.1))
                        .overlay {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .stilystPrimary))
                        }
                }
                .frame(height: 160) // Fixed height to prevent stretching
                .clipped()
                
                // Gradient overlay for better text readability
                LinearGradient(
                    colors: [Color.clear, Color.black.opacity(0.1)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Trending badge with new color palette
                if style.trending {
                    VStack {
                        HStack {
                            Spacer()
                            HStack(spacing: 4) {
                                Image(systemName: "flame.fill")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                Text("Trending")
                                    .font(.stilystCaption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.stilystPrimary, in: Capsule())
                            .padding(.top, 12)
                            .padding(.trailing, 12)
                        }
                        Spacer()
                    }
                }
            }
            .cornerRadius(16, corners: [.topLeft, .topRight]) // Rounded top corners only
            
            // Content section with enhanced styling
            VStack(alignment: .leading, spacing: 12) {
                // Style name with better typography
                Text(style.name)
                    .font(.stilystTitle3)
                    .fontWeight(.semibold)
                    .foregroundColor(.stilystText)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                // Metrics with improved visual hierarchy
                HStack(spacing: 20) {
                    HStack(spacing: 6) {
                        Image(systemName: "eye.fill")
                            .font(.caption)
                            .foregroundColor(.stilystPrimary)
                        Text("\(style.viewCount)")
                            .font(.stilystCaption)
                            .fontWeight(.medium)
                            .foregroundColor(.stilystSecondaryText)
                    }
                    
                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .font(.caption)
                            .foregroundColor(.stilystPrimary)
                        Text("\(style.bookingCount)")
                            .font(.stilystCaption)
                            .fontWeight(.medium)
                            .foregroundColor(.stilystSecondaryText)
                    }
                }
            }
            .padding(16)
        }
        .background(Color.stilystSurface)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.stilystBorder, lineWidth: 0.5)
        )
        .shadow(color: .stilystShadow, radius: 8, x: 0, y: 4) // More prominent shadow
    }
}

// Extension for rounded corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// ViewModel for managing styles data
class StylesFeedViewModel: ObservableObject {
    @Published var styles: [Style] = []
    @Published var isLoading = false
    
    private let styleService = StyleService()
    
    func loadStyles(for category: ServiceCategory, location: String = "Near You") {
        isLoading = true
        
        if location == "Near You" {
            // Load local trending styles (based on user's location)
            styleService.fetchLocalTrendingStyles(for: category) { [weak self] fetchedStyles in
                DispatchQueue.main.async {
                    self?.styles = fetchedStyles
                    self?.isLoading = false
                }
            }
        } else {
            // Load global trending styles for inspiration
            styleService.fetchGlobalTrendingStyles(for: category, city: location) { [weak self] fetchedStyles in
                DispatchQueue.main.async {
                    self?.styles = fetchedStyles
                    self?.isLoading = false
                }
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

