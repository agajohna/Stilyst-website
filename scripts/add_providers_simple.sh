#!/bin/bash

# Simple script to add providers to Firebase using REST API
# Your Firebase project: stilyst-2a5c4

echo "🚀 Adding sample providers to Firebase Firestore..."
echo ""

PROJECT_ID="stilyst-2a5c4"
BASE_URL="https://firestore.googleapis.com/v1/projects/${PROJECT_ID}/databases/(default)/documents"

# You'll need to get your Web API Key from Firebase Console
# Go to: Project Settings > General > Web API Key
echo "📝 To use this script, you need your Firebase Web API Key"
echo "Get it from: Firebase Console > Project Settings > General > Web API Key"
echo ""
read -p "Enter your Firebase Web API Key: " API_KEY

if [ -z "$API_KEY" ]; then
    echo "❌ API Key is required"
    exit 1
fi

# Provider 1: Marcus Johnson
echo "Adding Marcus Johnson..."
curl -X POST "${BASE_URL}/providers?key=${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "fields": {
      "serviceCategory": {"stringValue": "Men'\''s Hairstyles"},
      "name": {"stringValue": "Marcus Johnson"},
      "businessName": {"stringValue": "Elite Cuts Barbershop"},
      "bio": {"stringValue": "Master barber with 12 years of experience specializing in fades and modern men'\''s styles."},
      "profileImageURL": {"stringValue": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400"},
      "rating": {"doubleValue": 4.9},
      "reviewCount": {"integerValue": 234},
      "priceRange": {"stringValue": "$$"},
      "specialties": {
        "arrayValue": {
          "values": [
            {"stringValue": "Style 1"},
            {"stringValue": "Style 2"}
          ]
        }
      },
      "latitude": {"doubleValue": 37.7749},
      "longitude": {"doubleValue": -122.4194},
      "address": {"stringValue": "123 Market Street"},
      "city": {"stringValue": "San Francisco"},
      "state": {"stringValue": "CA"},
      "zipCode": {"stringValue": "94102"}
    }
  }'

echo ""
echo "✅ Added Marcus Johnson"
echo ""

# Provider 2: David Chen
echo "Adding David Chen..."
curl -X POST "${BASE_URL}/providers?key=${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "fields": {
      "serviceCategory": {"stringValue": "Men'\''s Hairstyles"},
      "name": {"stringValue": "David Chen"},
      "businessName": {"stringValue": "Precision Barber Studio"},
      "bio": {"stringValue": "Award-winning barber specializing in precision cuts and contemporary styles."},
      "profileImageURL": {"stringValue": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400"},
      "rating": {"doubleValue": 4.8},
      "reviewCount": {"integerValue": 189},
      "priceRange": {"stringValue": "$$"},
      "specialties": {
        "arrayValue": {
          "values": [
            {"stringValue": "Style 1"},
            {"stringValue": "Style 2"}
          ]
        }
      },
      "latitude": {"doubleValue": 37.7849},
      "longitude": {"doubleValue": -122.4094},
      "address": {"stringValue": "456 Valencia Street"},
      "city": {"stringValue": "San Francisco"},
      "state": {"stringValue": "CA"},
      "zipCode": {"stringValue": "94110"}
    }
  }'

echo ""
echo "✅ Added David Chen"
echo ""

# Provider 3: James Rodriguez
echo "Adding James Rodriguez..."
curl -X POST "${BASE_URL}/providers?key=${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "fields": {
      "serviceCategory": {"stringValue": "Men'\''s Hairstyles"},
      "name": {"stringValue": "James Rodriguez"},
      "businessName": {"stringValue": "The Fade Factory"},
      "bio": {"stringValue": "Fade specialist with expertise in all fade variations. 8 years experience."},
      "profileImageURL": {"stringValue": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400"},
      "rating": {"doubleValue": 4.7},
      "reviewCount": {"integerValue": 156},
      "priceRange": {"stringValue": "$$"},
      "specialties": {
        "arrayValue": {
          "values": [
            {"stringValue": "Style 1"},
            {"stringValue": "Style 2"}
          ]
        }
      },
      "latitude": {"doubleValue": 37.7649},
      "longitude": {"doubleValue": -122.4294},
      "address": {"stringValue": "789 Mission Street"},
      "city": {"stringValue": "San Francisco"},
      "state": {"stringValue": "CA"},
      "zipCode": {"stringValue": "94103"}
    }
  }'

echo ""
echo "✅ Added James Rodriguez"
echo ""

echo "🎉 Successfully added 3 providers to Firestore!"
echo "Check Firebase Console to verify: https://console.firebase.google.com/project/${PROJECT_ID}/firestore"

