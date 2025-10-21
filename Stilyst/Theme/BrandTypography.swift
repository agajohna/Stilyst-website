//
//  BrandTypography.swift
//  Stilyst
//
//  Created on 10/21/2025.
//  Following Apple Human Interface Guidelines
//

import SwiftUI

extension Font {
    // Apple HIG Typography System - Using system fonts for native feel
    
    // Large Title - For main headings (34pt, bold)
    static let stilystLargeTitle = Font.largeTitle.weight(.bold)
    
    // Title - For section headers (28pt, bold)
    static let stilystTitle = Font.title.weight(.bold)
    
    // Title 2 - For subsection headers (22pt, bold)
    static let stilystTitle2 = Font.title2.weight(.bold)
    
    // Title 3 - For card headers (20pt, semibold)
    static let stilystTitle3 = Font.title3.weight(.semibold)
    
    // Headline - For important content (17pt, semibold)
    static let stilystHeadline = Font.headline.weight(.semibold)
    
    // Body - For main content (17pt, regular)
    static let stilystBody = Font.body
    static let stilystBodyEmphasized = Font.body.weight(.medium)
    
    // Callout - For secondary content (16pt, regular)
    static let stilystCallout = Font.callout
    
    // Subheadline - For captions (15pt, regular)
    static let stilystSubheadline = Font.subheadline
    
    // Footnote - For small text (13pt, regular)
    static let stilystFootnote = Font.footnote
    
    // Caption - For very small text (12pt, regular)
    static let stilystCaption = Font.caption
    
    // Caption 2 - For smallest text (11pt, regular)
    static let stilystCaption2 = Font.caption2
    
    // Button - For interactive elements (17pt, semibold)
    static let stilystButton = Font.body.weight(.semibold)
    
    // Tag - For labels and tags (13pt, medium)
    static let stilystTag = Font.footnote.weight(.medium)
    
    // Navigation - For navigation elements
    static let stilystNavigationTitle = Font.largeTitle.weight(.bold)
    static let stilystNavigationBarTitle = Font.title3.weight(.semibold)
}
