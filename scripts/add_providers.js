const admin = require('firebase-admin');

// Initialize Firebase Admin SDK
const serviceAccount = require('../Stilyst/GoogleService-Info.plist');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

// Sample providers data
const providers = [
  {
    name: "Marcus Johnson",
    businessName: "The Gentleman's Cut",
    bio: "Master barber with 10+ years of experience specializing in classic cuts and modern fades. Known for precision and attention to detail.",
    profileImageURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face",
    rating: 4.9,
    reviewCount: 127,
    priceRange: "$35-$50",
    specialties: ["classic-fade", "textured-crop", "pompadour", "buzz-cut"],
    portfolioImages: [
      {
        imageURL: "https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=400&h=400&fit=crop",
        styleId: "classic-fade",
        description: "Clean classic fade with textured top"
      },
      {
        imageURL: "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=400&h=400&fit=crop",
        styleId: "textured-crop",
        description: "Modern textured crop with natural styling"
      }
    ],
    location: {
      latitude: 34.0522,
      longitude: -118.2437,
      address: "123 Sunset Blvd, Los Angeles, CA 90028",
      city: "Los Angeles",
      state: "CA",
      zipCode: "90028"
    }
  },
  {
    name: "Alex Rodriguez",
    businessName: "Modern Barber Co.",
    bio: "Trendy barber shop focusing on contemporary styles and Instagram-worthy cuts. Expert in fades and styling.",
    profileImageURL: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face",
    rating: 4.8,
    reviewCount: 89,
    priceRange: "$40-$60",
    specialties: ["textured-crop", "classic-fade", "undercut", "comb-over"],
    portfolioImages: [
      {
        imageURL: "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=400&h=400&fit=crop",
        styleId: "textured-crop",
        description: "Sharp textured crop with side part"
      },
      {
        imageURL: "https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=400&h=400&fit=crop",
        styleId: "classic-fade",
        description: "Professional classic fade"
      }
    ],
    location: {
      latitude: 34.0736,
      longitude: -118.4004,
      address: "456 Melrose Ave, West Hollywood, CA 90046",
      city: "West Hollywood",
      state: "CA",
      zipCode: "90046"
    }
  },
  {
    name: "David Kim",
    businessName: "Precision Cuts",
    bio: "Award-winning barber with expertise in Asian hair textures and modern styling techniques. 15 years of experience.",
    profileImageURL: "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&h=400&fit=crop&crop=face",
    rating: 4.9,
    reviewCount: 156,
    priceRange: "$30-$45",
    specialties: ["textured-crop", "classic-fade", "asian-hair", "styling"],
    portfolioImages: [
      {
        imageURL: "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=400&h=400&fit=crop",
        styleId: "textured-crop",
        description: "Textured crop with natural Asian hair texture"
      }
    ],
    location: {
      latitude: 34.0522,
      longitude: -118.2437,
      address: "789 Koreatown Plaza, Los Angeles, CA 90006",
      city: "Los Angeles",
      state: "CA",
      zipCode: "90006"
    }
  },
  {
    name: "Mike Thompson",
    businessName: "Thompson's Barber Shop",
    bio: "Traditional barber shop with modern techniques. Family-owned business serving the community for 20+ years.",
    profileImageURL: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=400&fit=crop&crop=face",
    rating: 4.7,
    reviewCount: 203,
    priceRange: "$25-$40",
    specialties: ["classic-fade", "traditional-cuts", "beard-trimming"],
    portfolioImages: [
      {
        imageURL: "https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=400&h=400&fit=crop",
        styleId: "classic-fade",
        description: "Traditional classic fade with clean lines"
      }
    ],
    location: {
      latitude: 34.0736,
      longitude: -118.4004,
      address: "321 Main St, Santa Monica, CA 90401",
      city: "Santa Monica",
      state: "CA",
      zipCode: "90401"
    }
  }
];

async function addProviders() {
  try {
    console.log('Adding providers to Firebase...');
    
    for (const provider of providers) {
      const docRef = await db.collection('providers').add(provider);
      console.log(`Added provider: ${provider.name} with ID: ${docRef.id}`);
    }
    
    console.log('✅ Successfully added all providers!');
  } catch (error) {
    console.error('❌ Error adding providers:', error);
  }
}

addProviders();
