# Manual Guide: Add Providers to Firebase

Since we don't have Firebase Admin SDK set up, here's how to manually add providers to Firestore:

## Option 1: Using Firebase Console (Recommended)

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project: `stilyst-2a5c4`
3. Click **Firestore Database** in the left menu
4. Click **+ Start collection**
5. Collection ID: `providers`
6. Click **Next**

### Provider 1: Marcus Johnson

Add these fields:
- `serviceCategory` (string): `Men's Hairstyles`
- `name` (string): `Marcus Johnson`
- `businessName` (string): `Elite Cuts Barbershop`
- `bio` (string): `Master barber with 12 years of experience specializing in fades and modern men's styles.`
- `profileImageURL` (string): `https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400`
- `rating` (number): `4.9`
- `reviewCount` (number): `234`
- `priceRange` (string): `$$`
- `specialties` (array):
  - Click **+ Add item** and paste your Style IDs from the "Men's Hairstyles" collection
  - Example: `Style 1`, `Style 2`
- `latitude` (number): `37.7749`
- `longitude` (number): `-122.4194`
- `address` (string): `123 Market Street`
- `city` (string): `San Francisco`
- `state` (string): `CA`
- `zipCode` (string): `94102`

Click **Save**

### Provider 2: David Chen

Repeat with these fields:
- `serviceCategory` (string): `Men's Hairstyles`
- `name` (string): `David Chen`
- `businessName` (string): `Precision Barber Studio`
- `bio` (string): `Award-winning barber specializing in precision cuts and contemporary styles.`
- `profileImageURL` (string): `https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400`
- `rating` (number): `4.8`
- `reviewCount` (number): `189`
- `priceRange` (string): `$$`
- `specialties` (array): [Your Style IDs]
- `latitude` (number): `37.7849`
- `longitude` (number): `-122.4094`
- `address` (string): `456 Valencia Street`
- `city` (string): `San Francisco`
- `state` (string): `CA`
- `zipCode` (string): `94110`

### Provider 3: James Rodriguez

- `serviceCategory` (string): `Men's Hairstyles`
- `name` (string): `James Rodriguez`
- `businessName` (string): `The Fade Factory`
- `bio` (string): `Fade specialist with expertise in all fade variations. 8 years experience.`
- `profileImageURL` (string): `https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400`
- `rating` (number): `4.7`
- `reviewCount` (number): `156`
- `priceRange` (string): `$$`
- `specialties` (array): [Your Style IDs]
- `latitude` (number): `37.7649`
- `longitude` (number): `-122.4294`
- `address` (string): `789 Mission Street`
- `city` (string): `San Francisco`
- `state` (string): `CA`
- `zipCode` (string): `94103`

---

## Option 2: Quick Import (JSON)

I can also create a JSON file that you can import directly into Firestore.

---

## Need the Style IDs?

First, get your style IDs:
1. Go to Firebase Console
2. Open the "Men's Hairstyles" collection
3. Copy the document IDs (e.g., `Style 1`, `Style 2`)
4. Use these IDs in the `specialties` array for each provider

