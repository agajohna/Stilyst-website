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
    func fetchProviders(for styleId: String, completion: @escaping ([Provider]) -> Void) {
        db.collection("providers")
            .whereField("specialties", arrayContains: styleId)
            .order(by: "rating", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching providers: \(error)")
                    completion([])
                    return
                }
                
                var providers: [Provider] = []
                for doc in snapshot?.documents ?? [] {
                    let data = doc.data()
                    let provider = Provider(
                        id: doc.documentID,
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
                
                let provider = Provider(
                    id: snapshot?.documentID,
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
                    let provider = Provider(
                        id: doc.documentID,
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
