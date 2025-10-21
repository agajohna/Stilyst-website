//
//  Provider.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation
import CoreLocation

struct Provider: Identifiable, Codable, Hashable {
    var id: String?
    let name: String
    let businessName: String
    let bio: String
    let profileImageURL: String
    let rating: Double
    let reviewCount: Int
    let priceRange: String // e.g., "$$", "$$$"
    let specialties: [String] // Style IDs they specialize in
    let portfolioImages: [PortfolioImage]
    let location: LocationData
    let availability: [String] // Simplified - will expand later
    
    init(id: String? = nil,
         name: String,
         businessName: String,
         bio: String,
         profileImageURL: String,
         rating: Double,
         reviewCount: Int,
         priceRange: String,
         specialties: [String],
         portfolioImages: [PortfolioImage],
         location: LocationData,
         availability: [String] = []) {
        self.id = id
        self.name = name
        self.businessName = businessName
        self.bio = bio
        self.profileImageURL = profileImageURL
        self.rating = rating
        self.reviewCount = reviewCount
        self.priceRange = priceRange
        self.specialties = specialties
        self.portfolioImages = portfolioImages
        self.location = location
        self.availability = availability
    }
}

struct PortfolioImage: Identifiable, Codable, Hashable {
    let id: String
    let imageURL: String
    let styleId: String // Which style this work represents
    let caption: String?
    
    init(id: String = UUID().uuidString,
         imageURL: String,
         styleId: String,
         caption: String? = nil) {
        self.id = id
        self.imageURL = imageURL
        self.styleId = styleId
        self.caption = caption
    }
}

struct LocationData: Codable, Hashable {
    let latitude: Double
    let longitude: Double
    let address: String
    let city: String
    let state: String
    let zipCode: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // Custom Hashable implementation (coordinate is computed, so we don't include it)
    func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
        hasher.combine(address)
        hasher.combine(city)
        hasher.combine(state)
        hasher.combine(zipCode)
    }
    
    static func == (lhs: LocationData, rhs: LocationData) -> Bool {
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.address == rhs.address &&
        lhs.city == rhs.city &&
        lhs.state == rhs.state &&
        lhs.zipCode == rhs.zipCode
    }
}

