//
//  SocialContentManager.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation

class SocialContentManager: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isPinterestAuthenticated = false
    
    private let pinterestService: PinterestService?
    private let instagramService: InstagramService?
    
    init() {
        // Initialize Pinterest service with your App ID
        self.pinterestService = PinterestService()
        self.instagramService = nil // Configure when you set up Instagram
        
        // Check if Pinterest is configured
        self.isPinterestAuthenticated = APIConfiguration.isPinterestConfigured
    }
    
    // MARK: - Fetch Trending Content
    func fetchTrendingContent(for category: ServiceCategory, completion: @escaping ([Style]) -> Void) {
        isLoading = true
        errorMessage = nil
        
        var allStyles: [Style] = []
        let group = DispatchGroup()
        
        // Fetch from Pinterest
        if let pinterestService = pinterestService {
            group.enter()
            pinterestService.searchTrendingPins(query: "", category: category) { styles in
                allStyles.append(contentsOf: styles)
                group.leave()
            }
        }
        
        // Fetch from Instagram
        if let instagramService = instagramService {
            group.enter()
            instagramService.searchHashtagMedia(hashtag: "", category: category) { styles in
                allStyles.append(contentsOf: styles)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            // Sort by trending score and remove duplicates
            let uniqueStyles = self.removeDuplicates(from: allStyles)
            let sortedStyles = uniqueStyles.sorted { $0.trendingScore > $1.trendingScore }
            
            self.isLoading = false
            completion(sortedStyles)
        }
    }
    
    // MARK: - Helper Methods
    private func removeDuplicates(from styles: [Style]) -> [Style] {
        var seen = Set<String>()
        return styles.filter { style in
            let key = style.imageURL
            if seen.contains(key) {
                return false
            } else {
                seen.insert(key)
                return true
            }
        }
    }
    
    // MARK: - Pinterest Authentication
    func getPinterestAuthURL() -> URL? {
        return pinterestService?.getAuthorizationURL()
    }
    
    func authenticatePinterest(with code: String, completion: @escaping (Bool) -> Void) {
        pinterestService?.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.isPinterestAuthenticated = success
                completion(success)
            }
        }
    }
    
    // MARK: - Configuration Check
    var isConfigured: Bool {
        return pinterestService != nil || instagramService != nil
    }
    
    var configuredServices: [String] {
        var services: [String] = []
        if pinterestService != nil { services.append("Pinterest") }
        if instagramService != nil { services.append("Instagram") }
        return services
    }
    
    var pinterestStatus: String {
        if isPinterestAuthenticated {
            return "✅ Connected"
        } else if APIConfiguration.isPinterestConfigured {
            return "🔑 Ready to Connect"
        } else {
            return "⏳ Pending Approval"
        }
    }
}
