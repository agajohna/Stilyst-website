//
//  StyleService.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class StyleService: ObservableObject {
    private let db = Firestore.firestore()
    
    // MARK: - Fetch Styles
    func fetchStyles(for category: ServiceCategory, completion: @escaping ([Style]) -> Void) {
        db.collection("styles")
            .whereField("category", isEqualTo: category.rawValue)
            .order(by: "trendingScore", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching styles: \(error)")
                    completion([])
                    return
                }
                
                let styles = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Style.self)
                } ?? []
                
                completion(styles)
            }
    }
    
    // MARK: - Increment View Count
    func incrementViewCount(for styleId: String) {
        db.collection("styles").document(styleId)
            .updateData(["viewCount": FieldValue.increment(Int64(1))]) { error in
                if let error = error {
                    print("Error updating view count: \(error)")
                }
            }
    }
    
    // MARK: - Increment Booking Count
    func incrementBookingCount(for styleId: String) {
        db.collection("styles").document(styleId)
            .updateData(["bookingCount": FieldValue.increment(Int64(1))]) { error in
                if let error = error {
                    print("Error updating booking count: \(error)")
                }
            }
    }
}
