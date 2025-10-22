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
    
    // Social Media Integration
    let sourceType: SocialSourceType
    let sourceURL: String?
    let sourceId: String? // Pinterest pin ID or Instagram post ID
    let authorName: String?
    let authorProfileURL: String?
    let socialMetrics: SocialMetrics?
    
    // Computed property for trending score
    var trendingScore: Int {
        let baseScore = viewCount + (bookingCount * 10)
        let socialScore = socialMetrics?.engagementScore ?? 0
        return baseScore + socialScore
    }
    
    init(id: String? = nil,
         name: String,
         category: String,
         imageURL: String,
         description: String,
         tags: [String] = [],
         viewCount: Int = 0,
         bookingCount: Int = 0,
         trending: Bool = false,
         sourceType: SocialSourceType = .manual,
         sourceURL: String? = nil,
         sourceId: String? = nil,
         authorName: String? = nil,
         authorProfileURL: String? = nil,
         socialMetrics: SocialMetrics? = nil) {
        self.id = id
        self.name = name
        self.category = category
        self.imageURL = imageURL
        self.description = description
        self.tags = tags
        self.viewCount = viewCount
        self.bookingCount = bookingCount
        self.trending = trending
        self.sourceType = sourceType
        self.sourceURL = sourceURL
        self.sourceId = sourceId
        self.authorName = authorName
        self.authorProfileURL = authorProfileURL
        self.socialMetrics = socialMetrics
    }
}

// MARK: - Social Media Types
enum SocialSourceType: String, Codable, CaseIterable {
    case manual = "manual"
    case pinterest = "pinterest"
    case instagram = "instagram"
    case unsplash = "unsplash"
    
    var displayName: String {
        switch self {
        case .manual: return "Manual Upload"
        case .pinterest: return "Pinterest"
        case .instagram: return "Instagram"
        case .unsplash: return "Unsplash"
        }
    }
    
    var iconName: String {
        switch self {
        case .manual: return "photo"
        case .pinterest: return "p.circle.fill"
        case .instagram: return "camera.fill"
        case .unsplash: return "photo.fill"
        }
    }
}

struct SocialMetrics: Codable, Hashable {
    let likes: Int
    let comments: Int
    let shares: Int
    let saves: Int
    let engagementRate: Double
    
    var engagementScore: Int {
        return likes + (comments * 2) + (shares * 3) + (saves * 5)
    }
    
    init(likes: Int = 0, comments: Int = 0, shares: Int = 0, saves: Int = 0, engagementRate: Double = 0.0) {
        self.likes = likes
        self.comments = comments
        self.shares = shares
        self.saves = saves
        self.engagementRate = engagementRate
    }
}

