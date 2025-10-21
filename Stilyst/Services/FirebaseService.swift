//
//  FirebaseService.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebaseService: ObservableObject {
    static let shared = FirebaseService()
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    private init() {}
    
    // MARK: - App Configuration
    static func configure() {
        FirebaseApp.configure()
    }
    
    // MARK: - Firestore Collections
    enum Collection: String {
        case styles = "styles"
        case providers = "providers"
        case bookings = "bookings"
        case users = "users"
    }
    
    // MARK: - Storage References
    enum StorageFolder: String {
        case profileImages = "profile_images"
        case portfolioImages = "portfolio_images"
        case styleImages = "style_images"
    }
    
    func storageReference(for folder: StorageFolder, fileName: String) -> StorageReference {
        return storage.reference().child(folder.rawValue).child(fileName)
    }
}
