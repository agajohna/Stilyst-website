//
//  PinterestService.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation

class PinterestService: ObservableObject {
    private let appId: String
    private let appSecret: String?
    private let baseURL = "https://api.pinterest.com/v5"
    private var accessToken: String?
    
    init(appId: String = APIConfiguration.pinterestAppId, appSecret: String? = nil) {
        self.appId = appId
        self.appSecret = appSecret
    }
    
    // MARK: - OAuth Authentication
    func getAuthorizationURL() -> URL? {
        let redirectURI = APIConfiguration.pinterestRedirectURI.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let scope = "pins:read,boards:read,user_accounts:read"
        
        let urlString = "\(APIConfiguration.pinterestAuthURL)?client_id=\(appId)&redirect_uri=\(redirectURI)&response_type=code&scope=\(scope)"
        return URL(string: urlString)
    }
    
    func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        guard let appSecret = appSecret else {
            print("❌ Pinterest App Secret not configured")
            completion(false)
            return
        }
        
        let url = URL(string: "\(APIConfiguration.pinterestAuthURL)token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let body = "grant_type=authorization_code&client_id=\(appId)&client_secret=\(appSecret)&code=\(code)&redirect_uri=\(APIConfiguration.pinterestRedirectURI)"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(false)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PinterestTokenResponse.self, from: data)
                self.accessToken = response.accessToken
                completion(true)
            } catch {
                print("❌ Error exchanging code for token: \(error)")
                completion(false)
            }
        }.resume()
    }
    
    // MARK: - Search Trending Pins
    func searchTrendingPins(query: String, category: ServiceCategory, completion: @escaping ([Style]) -> Void) {
        guard let accessToken = accessToken else {
            print("❌ Pinterest access token not available")
            completion([])
            return
        }
        
        let searchQuery = buildSearchQuery(for: category)
        
        guard let url = URL(string: "\(baseURL)/search/pins?query=\(searchQuery)&limit=20") else {
            completion([])
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PinterestSearchResponse.self, from: data)
                let styles = response.data.compactMap { pin in
                    self.convertPinToStyle(pin: pin, category: category)
                }
                completion(styles)
            } catch {
                print("Error parsing Pinterest response: \(error)")
                completion([])
            }
        }.resume()
    }
    
    // MARK: - Helper Methods
    private func buildSearchQuery(for category: ServiceCategory) -> String {
        switch category {
        case .mensHair:
            return "mens+hairstyles+trending+2024"
        case .womensHair:
            return "womens+hairstyles+trending+2024"
        case .nails:
            return "nail+art+trending+2024"
        case .makeup:
            return "makeup+trending+2024"
        case .injectables:
            return "beauty+injectables+trending"
        case .glowUp:
            return "glow+up+transformation+2024"
        }
    }
    
    private func convertPinToStyle(pin: PinterestPin, category: ServiceCategory) -> Style? {
        guard let imageURL = pin.media?.images?["564x"]?.url ?? pin.media?.images?["736x"]?.url else {
            return nil
        }
        
        let socialMetrics = SocialMetrics(
            likes: pin.stats?.saves ?? 0,
            comments: pin.stats?.comments ?? 0,
            shares: pin.stats?.shares ?? 0,
            saves: pin.stats?.saves ?? 0
        )
        
        return Style(
            name: pin.title ?? "Trending Style",
            category: category.rawValue,
            imageURL: imageURL,
            description: pin.description ?? "Trending beauty style from Pinterest",
            tags: pin.tags ?? [],
            trending: true,
            sourceType: .pinterest,
            sourceURL: pin.url,
            sourceId: pin.id,
            authorName: pin.creator?.username,
            authorProfileURL: pin.creator?.profileUrl,
            socialMetrics: socialMetrics
        )
    }
}

// MARK: - Pinterest API Models
struct PinterestSearchResponse: Codable {
    let data: [PinterestPin]
}

struct PinterestPin: Codable {
    let id: String
    let title: String?
    let description: String?
    let url: String?
    let media: PinterestMedia?
    let creator: PinterestCreator?
    let tags: [String]?
    let stats: PinterestStats?
}

struct PinterestMedia: Codable {
    let images: [String: PinterestImage]?
}

struct PinterestImage: Codable {
    let url: String
    let width: Int
    let height: Int
}

struct PinterestCreator: Codable {
    let username: String
    let profileUrl: String?
}

struct PinterestStats: Codable {
    let saves: Int?
    let comments: Int?
    let shares: Int?
}

struct PinterestTokenResponse: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int?
    let scope: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
    }
}
