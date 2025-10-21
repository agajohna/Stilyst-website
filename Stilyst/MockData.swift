//
//  MockData.swift
//  Stilyst
//
//  Created on 10/21/2025.
//

import Foundation

struct MockData {
    // Sample styles
    static let styles: [Style] = [
        Style(
            id: "style1",
            name: "Classic Fade",
            category: ServiceCategory.mensHair.rawValue,
            imageURL: "https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=800",
            description: "A timeless fade that works for any occasion. Clean, professional, and easy to maintain.",
            tags: ["Fade", "Classic", "Low Maintenance"],
            viewCount: 1250,
            bookingCount: 89,
            trending: true
        ),
        Style(
            id: "style2",
            name: "Textured Crop",
            category: ServiceCategory.mensHair.rawValue,
            imageURL: "https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=800",
            description: "Modern textured crop with volume on top. Perfect for thick hair.",
            tags: ["Textured", "Modern", "Volume"],
            viewCount: 2100,
            bookingCount: 145,
            trending: true
        ),
        Style(
            id: "style3",
            name: "Undercut",
            category: ServiceCategory.mensHair.rawValue,
            imageURL: "https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=800",
            description: "Bold undercut style with longer top for versatile styling options.",
            tags: ["Undercut", "Bold", "Versatile"],
            viewCount: 1890,
            bookingCount: 112,
            trending: true
        ),
        Style(
            id: "style4",
            name: "Side Part",
            category: ServiceCategory.mensHair.rawValue,
            imageURL: "https://images.unsplash.com/photo-1633681926022-84c23e8cb2d6?w=800",
            description: "Classic side part for a sophisticated, professional look.",
            tags: ["Classic", "Professional", "Elegant"],
            viewCount: 950,
            bookingCount: 67,
            trending: false
        ),
        Style(
            id: "style5",
            name: "Buzz Cut",
            category: ServiceCategory.mensHair.rawValue,
            imageURL: "https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=800",
            description: "Clean, no-nonsense buzz cut. Ultra low maintenance.",
            tags: ["Buzz", "Simple", "Low Maintenance"],
            viewCount: 780,
            bookingCount: 54,
            trending: false
        ),
        Style(
            id: "style6",
            name: "Pompadour",
            category: ServiceCategory.mensHair.rawValue,
            imageURL: "https://images.unsplash.com/photo-1620216464872-d7d95a5e5dde?w=800",
            description: "Vintage-inspired pompadour with modern styling. Makes a statement.",
            tags: ["Pompadour", "Vintage", "Statement"],
            viewCount: 1450,
            bookingCount: 78,
            trending: true
        )
    ]
    
    // Sample providers
    static let providers: [Provider] = [
        Provider(
            id: "provider1",
            name: "Marcus Johnson",
            businessName: "Elite Cuts Barbershop",
            bio: "Master barber with 12 years of experience specializing in fades and modern men's styles. Certified in classic barbering techniques.",
            profileImageURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
            rating: 4.9,
            reviewCount: 234,
            priceRange: "$$",
            specialties: ["style1", "style2", "style3"],
            portfolioImages: [
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=400", styleId: "style1"),
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=400", styleId: "style2"),
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=400", styleId: "style3")
            ],
            location: LocationData(
                latitude: 37.7749,
                longitude: -122.4194,
                address: "123 Market Street",
                city: "San Francisco",
                state: "CA",
                zipCode: "94102"
            ),
            availability: ["Today 2PM", "Tomorrow 10AM", "Wed 3PM"]
        ),
        Provider(
            id: "provider2",
            name: "David Chen",
            businessName: "Precision Barber Studio",
            bio: "Award-winning barber specializing in precision cuts and contemporary styles. Featured in Men's Style Magazine 2024.",
            profileImageURL: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
            rating: 4.8,
            reviewCount: 189,
            priceRange: "$$$",
            specialties: ["style1", "style2", "style4", "style6"],
            portfolioImages: [
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=400", styleId: "style1"),
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=400", styleId: "style2"),
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1633681926022-84c23e8cb2d6?w=400", styleId: "style4")
            ],
            location: LocationData(
                latitude: 37.7849,
                longitude: -122.4094,
                address: "456 Valencia Street",
                city: "San Francisco",
                state: "CA",
                zipCode: "94110"
            ),
            availability: ["Today 4PM", "Tomorrow 1PM", "Fri 11AM"]
        ),
        Provider(
            id: "provider3",
            name: "James Rodriguez",
            businessName: "The Fade Factory",
            bio: "Fade specialist with expertise in all fade variations. 8 years experience making clients look their best.",
            profileImageURL: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400",
            rating: 4.7,
            reviewCount: 156,
            priceRange: "$$",
            specialties: ["style1", "style3", "style5"],
            portfolioImages: [
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=400", styleId: "style1"),
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=400", styleId: "style3"),
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=400", styleId: "style5")
            ],
            location: LocationData(
                latitude: 37.7649,
                longitude: -122.4294,
                address: "789 Mission Street",
                city: "San Francisco",
                state: "CA",
                zipCode: "94103"
            ),
            availability: ["Tomorrow 9AM", "Thu 2PM", "Sat 10AM"]
        ),
        Provider(
            id: "provider4",
            name: "Anthony Williams",
            businessName: "Sharp Edge Barbershop",
            bio: "Traditional barber offering classic cuts with a modern twist. Known for attention to detail and customer service.",
            profileImageURL: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400",
            rating: 4.9,
            reviewCount: 201,
            priceRange: "$$",
            specialties: ["style1", "style2", "style4", "style6"],
            portfolioImages: [
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=400", styleId: "style2"),
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1633681926022-84c23e8cb2d6?w=400", styleId: "style4"),
                PortfolioImage(imageURL: "https://images.unsplash.com/photo-1620216464872-d7d95a5e5dde?w=400", styleId: "style6")
            ],
            location: LocationData(
                latitude: 37.7549,
                longitude: -122.4394,
                address: "321 Hayes Street",
                city: "San Francisco",
                state: "CA",
                zipCode: "94102"
            ),
            availability: ["Today 3PM", "Wed 10AM", "Fri 2PM"]
        )
    ]
}

