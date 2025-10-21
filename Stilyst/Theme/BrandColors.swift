//
//  BrandColors.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI

extension Color {
    // Stilyst Brand Colors - Modern Minimalist (Tech-Beauty)
    
    // Primary Palette
    static let stilystBackground = Color(hex: "#FAF9F8")      // Soft White / Ivory
    static let stilystSecondary = Color(hex: "#D8CFC6")       // Warm Greige / Sand
    static let stilystAccent = Color(hex: "#E6B7A9")          // Muted Blush / Nude Rose
    static let stilystText = Color(hex: "#2E2E2E")            // Charcoal Slate
    static let stilystGold = Color(hex: "#CBA977")            // Subtle Gold Tint
    
    // Semantic Colors
    static let stilystPrimary = stilystGold                   // Primary buttons/actions
    static let stilystSurface = Color.white                   // Cards/surfaces
    static let stilystBorder = stilystSecondary.opacity(0.3)  // Subtle borders
    static let stilystShadow = Color.black.opacity(0.05)      // Soft shadows
    
    // Status Colors (keeping minimal)
    static let stilystSuccess = Color.green.opacity(0.7)
    static let stilystError = Color.red.opacity(0.7)
    static let stilystWarning = stilystGold.opacity(0.8)
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
