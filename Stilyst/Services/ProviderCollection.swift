//
//  ProviderCollection.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

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
                
                let providers = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Provider.self)
                } ?? []
                
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
                
                let provider = try? snapshot?.data(as: Provider.self)
                completion(provider)
            }
    }
    
    // MARK: - Search Providers by Location
    func searchProviders(near location: LocationData, radius: Double = 10.0, completion: @escaping ([Provider]) -> Void) {
        // Note: This is a simplified version. For production, you'd want to use GeoFirestore
        db.collection("providers")
            .whereField("city", isEqualTo: location.city)
            .whereField("state", isEqualTo: location.state)
            .order(by: "rating", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error searching providers: \(error)")
                    completion([])
                    return
                }
                
                let providers = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Provider.self)
                } ?? []
                
                completion(providers)
            }
    }
}
