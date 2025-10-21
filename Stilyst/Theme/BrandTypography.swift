//
//  BrandTypography.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import SwiftUI

extension Font {
    // Stilyst Typography - Clean, Modern Sans-Serif
    
    // Headlines
    static let stilystLargeTitle = Font.system(size: 34, weight: .bold, design: .default)
    static let stilystTitle = Font.system(size: 28, weight: .bold, design: .default)
    static let stilystTitle2 = Font.system(size: 22, weight: .semibold, design: .default)
    static let stilystTitle3 = Font.system(size: 20, weight: .semibold, design: .default)
    
    // Body Text
    static let stilystHeadline = Font.system(size: 17, weight: .semibold, design: .default)
    static let stilystBody = Font.system(size: 17, weight: .regular, design: .default)
    static let stilystCallout = Font.system(size: 16, weight: .regular, design: .default)
    static let stilystSubheadline = Font.system(size: 15, weight: .regular, design: .default)
    
    // Small Text
    static let stilystFootnote = Font.system(size: 13, weight: .regular, design: .default)
    static let stilystCaption = Font.system(size: 12, weight: .regular, design: .default)
    static let stilystCaption2 = Font.system(size: 11, weight: .regular, design: .default)
    
    // Special
    static let stilystButton = Font.system(size: 17, weight: .semibold, design: .default)
    static let stilystTag = Font.system(size: 13, weight: .medium, design: .default)
}
