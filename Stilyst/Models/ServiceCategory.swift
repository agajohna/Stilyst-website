//
//  ServiceCategory.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation

enum ServiceCategory: String, CaseIterable, Identifiable {
    case mensHair = "Men's Hairstyles"
    case womensHair = "Women's Hairstyles"
    case nails = "Nails"
    case makeup = "Makeup"
    case injectables = "Beauty Injectables"
    case glowUp = "Glow Up"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .mensHair: return "scissors"
        case .womensHair: return "comb"
        case .nails: return "hand.raised.fill"
        case .makeup: return "paintbrush.fill"
        case .injectables: return "cross.vial"
        case .glowUp: return "sparkles"
        }
    }
    
    var gradient: [String] {
        switch self {
        case .mensHair: return ["#4A90E2", "#357ABD"]
        case .womensHair: return ["#E94B8B", "#C72C6C"]
        case .nails: return ["#F39C12", "#E67E22"]
        case .makeup: return ["#9B59B6", "#8E44AD"]
        case .injectables: return ["#1ABC9C", "#16A085"]
        case .glowUp: return ["#FFD700", "#FFA500"]
        }
    }
}

