//
//  LocationPickerView.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI

struct LocationPickerView: View {
    @Binding var selectedLocation: String
    let popularCities: [String]
    let locationService: LocationService
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                // Header - Following Apple HIG typography hierarchy
                VStack(alignment: .leading, spacing: 8) {
                    Text("Choose Location")
                        .font(.stilystTitle2)
                        .foregroundColor(.stilystText)
                    
                    Text("See trending styles from different cities for inspiration")
                        .font(.stilystBody)
                        .foregroundColor(.stilystSecondaryText)
                }
                .padding(.horizontal, 20) // Apple HIG: 20pt horizontal padding
                
                // Location List
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(popularCities, id: \.self) { city in
                            LocationRow(
                                city: city,
                                isSelected: selectedLocation == city,
                                locationService: locationService
                            ) {
                                selectedLocation = city
                                dismiss()
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.stilystPrimary)
                }
            }
        }
    }
}

struct LocationRow: View {
    let city: String
    let isSelected: Bool
    let locationService: LocationService
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Icon
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.stilystPrimary : Color.stilystSecondaryText.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: city == "Near You" ? "location.fill" : "globe")
                        .font(.system(size: 16))
                        .foregroundColor(isSelected ? .white : .stilystSecondaryText)
                }
                
                // City name
                VStack(alignment: .leading, spacing: 2) {
                    Text(city)
                        .font(.stilystCallout)
                        .foregroundColor(.stilystText)
                    
                        if city == "Near You" {
                            if locationService.currentLocation != nil {
                                Text("Location enabled")
                                    .font(.stilystCaption)
                                    .foregroundColor(.stilystSecondaryText)
                            } else {
                                Text("Enable location access")
                                    .font(.stilystCaption)
                                    .foregroundColor(.stilystSecondaryText)
                            }
                        } else {
                            Text("Global inspiration")
                                .font(.stilystCaption)
                                .foregroundColor(.stilystSecondaryText)
                        }
                }
                
                Spacer()
                
                // Selection indicator
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.stilystPrimary)
                }
            }
            .padding(.horizontal, 20) // Apple HIG: 20pt horizontal padding
            .padding(.vertical, 16)   // Apple HIG: 16pt vertical padding
            .background(isSelected ? Color.stilystHighlight : Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LocationPickerView(
        selectedLocation: .constant("Near You"),
        popularCities: ["Near You", "Los Angeles, CA", "Copenhagen, Denmark"],
        locationService: LocationService.shared
    )
}
