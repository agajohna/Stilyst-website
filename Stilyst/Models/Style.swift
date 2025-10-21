//
//  Style.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation

struct Style: Identifiable, Codable, Hashable {
    var id: String?
    let name: String
    let category: String // ServiceCategory rawValue
    let imageURL: String
    let description: String
    let tags: [String]
    let viewCount: Int
    let bookingCount: Int
    let trending: Bool
    
    // Computed property for trending score
    var trendingScore: Int {
        viewCount + (bookingCount * 10) // Weight bookings more heavily
    }
    
    init(id: String? = nil,
         name: String,
         category: String,
         imageURL: String,
         description: String,
         tags: [String] = [],
         viewCount: Int = 0,
         bookingCount: Int = 0,
         trending: Bool = false) {
        self.id = id
        self.name = name
        self.category = category
        self.imageURL = imageURL
        self.description = description
        self.tags = tags
        self.viewCount = viewCount
        self.bookingCount = bookingCount
        self.trending = trending
    }
}

