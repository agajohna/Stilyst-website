//
//  BrandColors.swift
//  Stilyst
//
//  Created on 10/21/2025.
//  Following Apple Human Interface Guidelines
//

import SwiftUI

extension Color {
    // Apple HIG Color System - Following iOS design principles
    
    // MARK: - System Colors (Apple HIG recommended)
    static let stilystSystemBackground = Color(.systemBackground)
    static let stilystSecondarySystemBackground = Color(.secondarySystemBackground)
    static let stilystTertiarySystemBackground = Color(.tertiarySystemBackground)
    
    static let stilystLabel = Color(.label)
    static let stilystSecondaryLabel = Color(.secondaryLabel)
    static let stilystTertiaryLabel = Color(.tertiaryLabel)
    static let stilystQuaternaryLabel = Color(.quaternaryLabel)
    
    static let stilystSystemFill = Color(.systemFill)
    static let stilystSecondarySystemFill = Color(.secondarySystemFill)
    static let stilystTertiarySystemFill = Color(.tertiarySystemFill)
    static let stilystQuaternarySystemFill = Color(.quaternarySystemFill)
    
    static let stilystSeparator = Color(.separator)
    static let stilystOpaqueSeparator = Color(.opaqueSeparator)
    
    // MARK: - Brand Colors (Sophisticated Warm Palette)
    static let stilystPrimary = Color(hex: "#E7BFB2")          // Blush Nude - buttons, icons, highlights
    static let stilystBackground = Color(hex: "#FAF9F8")       // Soft Ivory - optional background
    static let stilystSurface = Color.white                    // Clean white for cards
    static let stilystText = Color(hex: "#4E4A46")            // Warm Charcoal - main text
    static let stilystSecondaryText = Color(hex: "#4E4A46").opacity(0.7) // Warm Charcoal with opacity
    static let stilystBorder = Color(hex: "#E7BFB2").opacity(0.3) // Subtle blush borders
    
    // MARK: - Semantic Colors (Apple HIG)
    static let stilystSuccess = Color.green
    static let stilystError = Color.red
    static let stilystWarning = Color.orange
    static let stilystInfo = Color.blue
    
    // MARK: - Interactive States (Using new palette)
    static let stilystHighlight = Color(hex: "#E7BFB2").opacity(0.2) // Blush highlight
    static let stilystPressed = Color(hex: "#E7BFB2").opacity(0.1)   // Blush pressed state
    
    // MARK: - Shadows (Warm and subtle)
    static let stilystShadow = Color(hex: "#4E4A46").opacity(0.1)    // Warm charcoal shadow
    static let stilystLightShadow = Color(hex: "#4E4A46").opacity(0.05) // Light warm shadow
    
    // MARK: - Additional Brand Colors
    static let stilystGold = Color(hex: "#CBA977")              // Keep for special accents
    static let stilystAccent = Color(hex: "#E7BFB2")           // Same as primary for consistency
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
