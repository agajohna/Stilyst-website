//
//  BrandTypography.swift
//  Stilyst
//
//  Created on 10/21/2025.
//  Using Maison Neue Font Family
//

import SwiftUI

extension Font {
    // MARK: - Maison Neue Typography System
    // Using Bold, Book (Regular), and Light weights
    // Falls back to SF Pro if Maison Neue is not available
    
    // Large Title - For main headings (34pt, bold)
    static let stilystLargeTitle = Font.custom("Maison Neue Bold", size: 34, relativeTo: .largeTitle)
    
    // Title - For section headers (28pt, bold)
    static let stilystTitle = Font.custom("Maison Neue Bold", size: 28, relativeTo: .title)
    
    // Title 2 - For subsection headers (22pt, bold)
    static let stilystTitle2 = Font.custom("Maison Neue Bold", size: 22, relativeTo: .title2)
    
    // Title 3 - For card headers (20pt, bold)
    static let stilystTitle3 = Font.custom("Maison Neue Bold", size: 20, relativeTo: .title3)
    
    // Headline - For important content (17pt, bold)
    static let stilystHeadline = Font.custom("Maison Neue Bold", size: 17, relativeTo: .headline)
    
    // Body - For main content (17pt, book/regular)
    static let stilystBody = Font.custom("Maison Neue Book", size: 17, relativeTo: .body)
    static let stilystBodyEmphasized = Font.custom("Maison Neue Bold", size: 17, relativeTo: .body)
    
    // Callout - For secondary content (16pt, book)
    static let stilystCallout = Font.custom("Maison Neue Book", size: 16, relativeTo: .callout)
    
    // Subheadline - For captions (15pt, book)
    static let stilystSubheadline = Font.custom("Maison Neue Book", size: 15, relativeTo: .subheadline)
    
    // Footnote - For small text (13pt, book)
    static let stilystFootnote = Font.custom("Maison Neue Book", size: 13, relativeTo: .footnote)
    
    // Caption - For very small text (12pt, book)
    static let stilystCaption = Font.custom("Maison Neue Book", size: 12, relativeTo: .caption)
    
    // Caption 2 - For smallest text (11pt, light)
    static let stilystCaption2 = Font.custom("Maison Neue Light", size: 11, relativeTo: .caption2)
    
    // Button - For interactive elements (17pt, bold)
    static let stilystButton = Font.custom("Maison Neue Bold", size: 17, relativeTo: .body)
    
    // Tag - For labels and tags (13pt, bold)
    static let stilystTag = Font.custom("Maison Neue Bold", size: 13, relativeTo: .footnote)
    
    // Navigation - For navigation elements
    static let stilystNavigationTitle = Font.custom("Maison Neue Bold", size: 34, relativeTo: .largeTitle)
    static let stilystNavigationBarTitle = Font.custom("Maison Neue Bold", size: 20, relativeTo: .title3)
}

// MARK: - Fallback Helper
// If custom font is not found, SwiftUI automatically falls back to system font
