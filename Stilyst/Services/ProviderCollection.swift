//
//  ProviderCollection.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation
import FirebaseFirestore
import CoreLocation

class ProviderCollection: ObservableObject {
    private let db = Firestore.firestore()
    
    // MARK: - Fetch Providers for Style
    func fetchProviders(for styleId: String, styleName: String, category: ServiceCategory, completion: @escaping ([Provider]) -> Void) {
        print("🔍 Fetching providers for style: \(styleName) in category: \(category.rawValue)")
        
        db.collection("providers")
            .whereField("serviceCategory", isEqualTo: category.rawValue)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("❌ Error fetching providers: \(error)")
                    completion([])
                    return
                }
                
                print("📊 Found \(snapshot?.documents.count ?? 0) providers in \(category.rawValue) category")
                
                var providers: [Provider] = []
                for doc in snapshot?.documents ?? [] {
                    let data = doc.data()
                    let serviceCategoryString = data["serviceCategory"] as? String ?? "Men's Hairstyles"
                    let serviceCategory = ServiceCategory(rawValue: serviceCategoryString) ?? .mensHair
                    let specialties = data["specialties"] as? [String] ?? []
                    
                    // Check if provider specializes in this style
                    let matchesStyle = specialties.contains { specialty in
                        specialty.localizedCaseInsensitiveContains(styleName) ||
                        styleName.localizedCaseInsensitiveContains(specialty)
                    }
                    
                    // Only include providers who specialize in this style
                    guard matchesStyle else { continue }
                    
                    print("✅ Found matching provider: \(data["name"] as? String ?? "") with specialties: \(specialties)")
                    
                    let provider = Provider(
                        id: doc.documentID,
                        serviceCategory: serviceCategory,
                        name: data["name"] as? String ?? "",
                        businessName: data["businessName"] as? String ?? "",
                        bio: data["bio"] as? String ?? "",
                        profileImageURL: data["profileImageURL"] as? String ?? "",
                        rating: data["rating"] as? Double ?? 0.0,
                        reviewCount: data["reviewCount"] as? Int ?? 0,
                        priceRange: data["priceRange"] as? String ?? "",
                        specialties: specialties,
                        portfolioImages: [],
                        location: LocationData(
                            latitude: data["latitude"] as? Double ?? 0.0,
                            longitude: data["longitude"] as? Double ?? 0.0,
                            address: data["address"] as? String ?? "",
                            city: data["city"] as? String ?? "",
                            state: data["state"] as? String ?? "",
                            zipCode: data["zipCode"] as? String ?? ""
                        )
                    )
                    providers.append(provider)
                }
                
                print("🎯 Returning \(providers.count) providers for \(styleName)")
                completion(providers)
            }
    }
    
    // MARK: - Fetch Provider by ID
    func fetchProvider(by id: String, completion: @escaping (Provider?) -> Void) {
        db.collection("providers").document(id)
            .getDocument { snapshot, error in
                if let error = error {
                    print("Error fetching provider: \(error)")
                    completion(nil)
                    return
                }
                
                guard let data = snapshot?.data() else {
                    completion(nil)
                    return
                }
                
                let serviceCategoryString = data["serviceCategory"] as? String ?? "Men's Hairstyles"
                let serviceCategory = ServiceCategory(rawValue: serviceCategoryString) ?? .mensHair
                
                let provider = Provider(
                    id: snapshot?.documentID,
                    serviceCategory: serviceCategory,
                    name: data["name"] as? String ?? "",
                    businessName: data["businessName"] as? String ?? "",
                    bio: data["bio"] as? String ?? "",
                    profileImageURL: data["profileImageURL"] as? String ?? "",
                    rating: data["rating"] as? Double ?? 0.0,
                    reviewCount: data["reviewCount"] as? Int ?? 0,
                    priceRange: data["priceRange"] as? String ?? "",
                    specialties: data["specialties"] as? [String] ?? [],
                    portfolioImages: [],
                    location: LocationData(
                        latitude: 0.0,
                        longitude: 0.0,
                        address: "",
                        city: "",
                        state: "",
                        zipCode: ""
                    )
                )
                completion(provider)
            }
    }
    
    // MARK: - Search Providers by Location
    func searchProviders(near userLocation: CLLocation, radius: Double = 10.0, completion: @escaping ([Provider]) -> Void) {
        // Note: This is a simplified version. For production, you'd want to use GeoFirestore
        db.collection("providers")
            .order(by: "rating", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error searching providers: \(error)")
                    completion([])
                    return
                }
                
                var providers: [Provider] = []
                for doc in snapshot?.documents ?? [] {
                    let data = doc.data()
                    let serviceCategoryString = data["serviceCategory"] as? String ?? "Men's Hairstyles"
                    let serviceCategory = ServiceCategory(rawValue: serviceCategoryString) ?? .mensHair
                    
                    let provider = Provider(
                        id: doc.documentID,
                        serviceCategory: serviceCategory,
                        name: data["name"] as? String ?? "",
                        businessName: data["businessName"] as? String ?? "",
                        bio: data["bio"] as? String ?? "",
                        profileImageURL: data["profileImageURL"] as? String ?? "",
                        rating: data["rating"] as? Double ?? 0.0,
                        reviewCount: data["reviewCount"] as? Int ?? 0,
                        priceRange: data["priceRange"] as? String ?? "",
                        specialties: data["specialties"] as? [String] ?? [],
                        portfolioImages: [],
                        location: LocationData(
                            latitude: data["latitude"] as? Double ?? 0.0,
                            longitude: data["longitude"] as? Double ?? 0.0,
                            address: data["address"] as? String ?? "",
                            city: data["city"] as? String ?? "",
                            state: data["state"] as? String ?? "",
                            zipCode: data["zipCode"] as? String ?? ""
                        )
                    )
                    providers.append(provider)
                }
                
                completion(providers)
            }
    }
}
