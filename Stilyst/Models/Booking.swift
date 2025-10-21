//
//  Booking.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation

struct Booking: Identifiable, Codable {
    let id: String
    let userId: String
    let providerId: String
    let styleId: String
    let referenceImageURL: String // The original trending style photo
    let customerTryOnImageURL: String? // AI try-on photo (optional for now)
    let appointmentDate: Date
    let appointmentTime: String
    let price: Double
    let status: BookingStatus
    let specialInstructions: String?
    let createdAt: Date
    
    init(id: String = UUID().uuidString,
         userId: String,
         providerId: String,
         styleId: String,
         referenceImageURL: String,
         customerTryOnImageURL: String? = nil,
         appointmentDate: Date,
         appointmentTime: String,
         price: Double,
         status: BookingStatus = .pending,
         specialInstructions: String? = nil,
         createdAt: Date = Date()) {
        self.id = id
        self.userId = userId
        self.providerId = providerId
        self.styleId = styleId
        self.referenceImageURL = referenceImageURL
        self.customerTryOnImageURL = customerTryOnImageURL
        self.appointmentDate = appointmentDate
        self.appointmentTime = appointmentTime
        self.price = price
        self.status = status
        self.specialInstructions = specialInstructions
        self.createdAt = createdAt
    }
}

enum BookingStatus: String, Codable {
    case pending = "Pending"
    case confirmed = "Confirmed"
    case completed = "Completed"
    case cancelled = "Cancelled"
}

