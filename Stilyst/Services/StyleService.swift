//
//  StyleService.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation
import FirebaseFirestore

class StyleService: ObservableObject {
    private let db = Firestore.firestore()
    
    // MARK: - Fetch Local Trending Styles (Near You)
    func fetchLocalTrendingStyles(for category: ServiceCategory, completion: @escaping ([Style]) -> Void) {
        print("🔍 Fetching styles for category: \(category.rawValue)")
        
        // First, let's try to get all documents to see what's there
        db.collection("Men's Hairstyles").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching all styles: \(error)")
            } else {
                print("📊 Total documents in styles collection: \(snapshot?.documents.count ?? 0)")
                for doc in snapshot?.documents ?? [] {
                    let data = doc.data()
                    print("📄 Document \(doc.documentID): \(data)")
                }
            }
        }
        
        // Also try with capital S in case that's the issue
        db.collection("styles").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching Styles collection: \(error)")
            } else {
                print("📊 Total documents in Styles collection: \(snapshot?.documents.count ?? 0)")
            }
        }
        
        // Now try the category-specific query
        db.collection("Men's Hairstyles")
            .whereField("category", isEqualTo: category.rawValue)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("❌ Error fetching styles: \(error)")
                    completion([])
                    return
                }
                
                print("📊 Found \(snapshot?.documents.count ?? 0) documents")
                
                var styles: [Style] = []
                for doc in snapshot?.documents ?? [] {
                    let data = doc.data()
                    
                    // Handle both field name formats (Style 1 vs Style 2)
                    let name = data["name"] as? String ?? data["Name"] as? String ?? ""
                    let category = data["category"] as? String ?? data["Category"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? data["Image URL"] as? String ?? ""
                    let description = data["description"] as? String ?? data["Description"] as? String ?? ""
                    let tags = data["tags"] as? [String] ?? data["Tags"] as? [String] ?? []
                    let viewCount = data["viewCount"] as? Int ?? data["View Count"] as? Int ?? 0
                    let bookingCount = data["bookingCount"] as? Int ?? data["Booking Count"] as? Int ?? 0
                    let trending = data["trending"] as? Bool ?? data["Trending"] as? Bool ?? false
                    
                    let style = Style(
                        id: doc.documentID,
                        name: name,
                        category: category,
                        imageURL: imageURL,
                        description: description,
                        tags: tags,
                        viewCount: viewCount,
                        bookingCount: bookingCount,
                        trending: trending
                    )
                    styles.append(style)
                }
                
                print("✅ Successfully loaded \(styles.count) styles")
                completion(styles)
            }
    }
    
    // MARK: - Increment View Count
    func incrementViewCount(for styleId: String) {
        db.collection("Men's Hairstyles").document(styleId)
            .updateData(["viewCount": FieldValue.increment(Int64(1))]) { error in
                if let error = error {
                    print("Error updating view count: \(error)")
                }
            }
    }
    
    // MARK: - Increment Booking Count
    func incrementBookingCount(for styleId: String) {
        db.collection("Men's Hairstyles").document(styleId)
            .updateData(["bookingCount": FieldValue.increment(Int64(1))]) { error in
                if let error = error {
                    print("Error updating booking count: \(error)")
                }
            }
    }
    
    // MARK: - Fetch Global Trending Styles (For Inspiration)
    func fetchGlobalTrendingStyles(for category: ServiceCategory, city: String, completion: @escaping ([Style]) -> Void) {
        print("🌍 Fetching global trending styles for \(city)")
        
        // For now, we'll return the same styles but could be enhanced to show city-specific trending data
        // In the future, this could query different collections or use city-specific trending algorithms
        db.collection("Men's Hairstyles")
            .whereField("category", isEqualTo: category.rawValue)
            .order(by: "viewCount", descending: true)
            .limit(to: 10) // Show top 10 globally trending styles
            .getDocuments { snapshot, error in
                if let error = error {
                    print("❌ Error fetching global styles: \(error)")
                    completion([])
                    return
                }
                
                print("📊 Found \(snapshot?.documents.count ?? 0) global trending documents")
                
                var styles: [Style] = []
                for doc in snapshot?.documents ?? [] {
                    let data = doc.data()
                    
                    // Handle both field name formats (Style 1 vs Style 2)
                    let name = data["name"] as? String ?? data["Name"] as? String ?? ""
                    let category = data["category"] as? String ?? data["Category"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? data["Image URL"] as? String ?? ""
                    let description = data["description"] as? String ?? data["Description"] as? String ?? ""
                    let tags = data["tags"] as? [String] ?? data["Tags"] as? [String] ?? []
                    let viewCount = data["viewCount"] as? Int ?? data["View Count"] as? Int ?? 0
                    let bookingCount = data["bookingCount"] as? Int ?? data["Booking Count"] as? Int ?? 0
                    let trending = data["trending"] as? Bool ?? data["Trending"] as? Bool ?? false
                    
                    let style = Style(
                        id: doc.documentID,
                        name: name,
                        category: category,
                        imageURL: imageURL,
                        description: description,
                        tags: tags,
                        viewCount: viewCount,
                        bookingCount: bookingCount,
                        trending: trending
                    )
                    styles.append(style)
                }
                
                print("✅ Successfully loaded \(styles.count) global trending styles for \(city)")
                completion(styles)
            }
    }
}
