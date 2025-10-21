# Adding Sample Providers to Firebase

## Instructions:

1. **Go to Firebase Console**: https://console.firebase.google.com/project/stilyst-2a5c4/firestore
2. **Create a new collection** called `providers`
3. **Add these sample provider documents**:

### Provider 1: Marcus Johnson
```json
{
  "name": "Marcus Johnson",
  "businessName": "The Gentleman's Cut",
  "bio": "Master barber with 10+ years of experience specializing in classic cuts and modern fades. Known for precision and attention to detail.",
  "profileImageURL": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face",
  "rating": 4.9,
  "reviewCount": 127,
  "priceRange": "$35-$50",
  "specialties": ["classic-fade", "textured-crop", "pompadour", "buzz-cut"],
  "portfolioImages": [
    {
      "imageURL": "https://images.unsplash.com/photo-1621605815971-fbc98d665033?w=400&h=400&fit=crop",
      "styleId": "classic-fade",
      "description": "Clean classic fade with textured top"
    },
    {
      "imageURL": "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=400&h=400&fit=crop",
      "styleId": "textured-crop", 
      "description": "Modern textured crop with natural styling"
    }
  ],
  "location": {
    "latitude": 34.0522,
    "longitude": -118.2437,
    "address": "123 Sunset Blvd, Los Angeles, CA 90028",
    "city": "Los Angeles",
    "state": "CA",
    "zipCode": "90028"
  }
}
```

### Provider 2: Alex Rodriguez
```json
{
  "name": "Alex Rodriguez",
  "businessName": "Modern Barber Co.",
  "bio": "Trendy barber shop focusing on contemporary styles and Instagram-worthy cuts. Expert in fades and styling.",
  "profileImageURL": "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face",
  "rating": 4.8,
  "reviewCount": 89,
  "priceRange": "$40-$60",
  "specialties": ["textured-crop", "classic-fade", "undercut", "comb-over"],
  "portfolioImages": [
    {
      "imageURL": "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=400&h=400&fit=crop",
      "styleId": "textured-crop",
      "description": "Sharp textured crop with side part"
    }
  ],
  "location": {
    "latitude": 34.0736,
    "longitude": -118.4004,
    "address": "456 Melrose Ave, West Hollywood, CA 90046",
    "city": "West Hollywood", 
    "state": "CA",
    "zipCode": "90046"
  }
}
```

### Provider 3: David Kim
```json
{
  "name": "David Kim",
  "businessName": "Precision Cuts",
  "bio": "Award-winning barber with expertise in Asian hair textures and modern styling techniques. 15 years of experience.",
  "profileImageURL": "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&h=400&fit=crop&crop=face",
  "rating": 4.9,
  "reviewCount": 156,
  "priceRange": "$30-$45",
  "specialties": ["textured-crop", "classic-fade", "asian-hair", "styling"],
  "portfolioImages": [
    {
      "imageURL": "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?w=400&h=400&fit=crop",
      "styleId": "textured-crop",
      "description": "Textured crop with natural Asian hair texture"
    }
  ],
  "location": {
    "latitude": 34.0522,
    "longitude": -118.2437,
    "address": "789 Koreatown Plaza, Los Angeles, CA 90006",
    "city": "Los Angeles",
    "state": "CA", 
    "zipCode": "90006"
  }
}
```

## Important Notes:

1. **Collection Name**: Make sure to create the collection as `providers` (lowercase)
2. **Document IDs**: Let Firebase auto-generate the document IDs
3. **Style IDs**: The `specialties` array should match the style IDs from your styles collection
4. **Portfolio Images**: Each image should have a `styleId` that matches your existing styles

## After Adding Providers:

The "View All Specialists" button should now show these providers when you tap on a style that matches their specialties!
