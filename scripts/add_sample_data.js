// Sample data to add to Firestore
// You can copy this data and add it manually in Firebase Console

const sampleStyles = [
  {
    id: "style1",
    name: "Classic Fade",
    category: "Men's Hairstyles",
    imageURL: "https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=800",
    description: "A timeless fade that works for any occasion. Clean, professional, and easy to maintain.",
    tags: ["Fade", "Classic", "Low Maintenance"],
    viewCount: 1250,
    bookingCount: 89,
    trending: true
  },
  {
    id: "style2", 
    name: "Textured Crop",
    category: "Men's Hairstyles",
    imageURL: "https://images.unsplash.com/photo-1605497788044-5a32c7078486?w=800",
    description: "Modern textured crop with volume on top. Perfect for thick hair.",
    tags: ["Textured", "Modern", "Volume"],
    viewCount: 2100,
    bookingCount: 145,
    trending: true
  }
];

const sampleProviders = [
  {
    id: "provider1",
    name: "Marcus Johnson",
    businessName: "Elite Cuts Barbershop",
    bio: "Master barber with 12 years of experience specializing in fades and modern men's styles.",
    profileImageURL: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
    rating: 4.9,
    reviewCount: 234,
    priceRange: "$$",
    specialties: ["style1", "style2"],
    portfolioImages: [
      {
        id: "portfolio1",
        imageURL: "https://images.unsplash.com/photo-1622286342621-4bd786c2447c?w=400",
        styleId: "style1",
        caption: "Classic fade example"
      }
    ],
    location: {
      latitude: 37.7749,
      longitude: -122.4194,
      address: "123 Market Street",
      city: "San Francisco",
      state: "CA",
      zipCode: "94102"
    },
    availability: ["Today 2PM", "Tomorrow 10AM", "Wed 3PM"]
  }
];

console.log("Sample data ready to copy to Firestore!");
console.log("Go to Firebase Console → Firestore Database → Start collection");
console.log("Create collection: 'styles' and add the sampleStyles data");
console.log("Create collection: 'providers' and add the sampleProviders data");
