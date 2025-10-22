//
//  APIConfiguration.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation

struct APIConfiguration {
    // MARK: - Pinterest Configuration
    static let pinterestAppId = "1534611"
    static let pinterestAppSecret = "YOUR_SECRET_KEY_HERE" // Replace when you get it
    static let pinterestRedirectURI = "https://stilyst.app/oauth/pinterest"
    
    // MARK: - Instagram Configuration
    static let instagramAppId = "YOUR_INSTAGRAM_APP_ID"
    static let instagramAppSecret = "YOUR_INSTAGRAM_SECRET"
    static let instagramRedirectURI = "https://stilyst.app/oauth/instagram"
    
    // MARK: - API Status
    static var isPinterestConfigured: Bool {
        return !pinterestAppSecret.contains("YOUR_SECRET_KEY_HERE")
    }
    
    static var isInstagramConfigured: Bool {
        return !instagramAppId.contains("YOUR_INSTAGRAM_APP_ID")
    }
    
    // MARK: - Pinterest API URLs
    static let pinterestBaseURL = "https://api.pinterest.com/v5"
    static let pinterestAuthURL = "https://www.pinterest.com/oauth/"
    
    // MARK: - Instagram API URLs
    static let instagramBaseURL = "https://graph.instagram.com"
    static let instagramAuthURL = "https://api.instagram.com/oauth/authorize"
}
