//
//  InstagramService.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation

class InstagramService: ObservableObject {
    private let accessToken: String
    private let baseURL = "https://graph.instagram.com"
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    // MARK: - Search Hashtag Media
    func searchHashtagMedia(hashtag: String, category: ServiceCategory, completion: @escaping ([Style]) -> Void) {
        let hashtagId = getHashtagId(for: category)
        
        guard let url = URL(string: "\(baseURL)/\(hashtagId)/top_media?access_token=\(accessToken)&limit=20") else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(InstagramMediaResponse.self, from: data)
                let styles = response.data.compactMap { media in
                    self.convertMediaToStyle(media: media, category: category)
                }
                completion(styles)
            } catch {
                print("Error parsing Instagram response: \(error)")
                completion([])
            }
        }.resume()
    }
    
    // MARK: - Helper Methods
    private func getHashtagId(for category: ServiceCategory) -> String {
        switch category {
        case .mensHair:
            return "17843857320044704" // #menshairstyles
        case .womensHair:
            return "17843857320044705" // #womenshairstyles
        case .nails:
            return "17843857320044706" // #nailart
        case .makeup:
            return "17843857320044707" // #makeup
        case .injectables:
            return "17843857320044708" // #beautyinjectables
        case .glowUp:
            return "17843857320044709" // #glowup
        }
    }
    
    private func convertMediaToStyle(media: InstagramMedia, category: ServiceCategory) -> Style? {
        guard let imageURL = media.mediaUrl else { return nil }
        
        let socialMetrics = SocialMetrics(
            likes: media.likeCount ?? 0,
            comments: media.commentsCount ?? 0,
            shares: 0, // Instagram doesn't provide share count
            saves: 0   // Instagram doesn't provide save count
        )
        
        return Style(
            name: "Trending \(category.rawValue)",
            category: category.rawValue,
            imageURL: imageURL,
            description: media.caption ?? "Trending beauty style from Instagram",
            tags: extractHashtags(from: media.caption ?? ""),
            trending: true,
            sourceType: .instagram,
            sourceURL: media.permalink,
            sourceId: media.id,
            authorName: media.username,
            socialMetrics: socialMetrics
        )
    }
    
    private func extractHashtags(from caption: String) -> [String] {
        let hashtagPattern = #"#\w+"#
        let regex = try? NSRegularExpression(pattern: hashtagPattern)
        let matches = regex?.matches(in: caption, range: NSRange(caption.startIndex..., in: caption)) ?? []
        
        return matches.compactMap { match in
            if let range = Range(match.range, in: caption) {
                return String(caption[range]).replacingOccurrences(of: "#", with: "")
            }
            return nil
        }
    }
}

// MARK: - Instagram API Models
struct InstagramMediaResponse: Codable {
    let data: [InstagramMedia]
}

struct InstagramMedia: Codable {
    let id: String
    let mediaType: String
    let mediaUrl: String?
    let caption: String?
    let permalink: String?
    let username: String?
    let likeCount: Int?
    let commentsCount: Int?
}
