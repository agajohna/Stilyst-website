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
    
    // MARK: - Brand Colors (Soft Industrial Palette)
    // Iron Gray (#3B3C3E), Ash White (#F3F2F0), Copper Mist (#C8A07A)
    // Sleek, mature, and subtly warm — premium design with human touch
    static let stilystPrimary = Color(hex: "#C8A07A")          // Copper Mist - buttons, icons, highlights
    static let stilystBackground = Color(hex: "#F3F2F0")       // Ash White - main background
    static let stilystSurface = Color.white                    // Clean white for cards
    static let stilystText = Color(hex: "#3B3C3E")            // Iron Gray - main text
    static let stilystSecondaryText = Color(hex: "#3B3C3E").opacity(0.7) // Iron Gray with opacity
    static let stilystBorder = Color(hex: "#C8A07A").opacity(0.3) // Subtle copper borders
    
    // MARK: - Semantic Colors (Apple HIG)
    static let stilystSuccess = Color.green
    static let stilystError = Color.red
    static let stilystWarning = Color.orange
    static let stilystInfo = Color.blue
    
    // MARK: - Interactive States (Soft Industrial)
    static let stilystHighlight = Color(hex: "#C8A07A").opacity(0.2) // Copper highlight
    static let stilystPressed = Color(hex: "#C8A07A").opacity(0.1)   // Copper pressed state
    
    // MARK: - Shadows (Industrial and subtle)
    static let stilystShadow = Color(hex: "#3B3C3E").opacity(0.1)    // Iron gray shadow
    static let stilystLightShadow = Color(hex: "#3B3C3E").opacity(0.05) // Light iron shadow
    
    // MARK: - Additional Brand Colors
    static let stilystGold = Color(hex: "#C8A07A")              // Copper Mist for special accents
    static let stilystAccent = Color(hex: "#C8A07A")           // Same as primary for consistency
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
