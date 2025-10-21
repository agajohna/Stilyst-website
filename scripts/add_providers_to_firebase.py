#!/usr/bin/env python3
"""
Script to add sample providers to Firebase Firestore
"""

import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase Admin SDK
# You'll need to download your service account key from Firebase Console
# Go to: Project Settings > Service Accounts > Generate New Private Key

try:
    cred = credentials.Certificate('firebase-adminsdk-key.json')
    firebase_admin.initialize_app(cred)
except:
    print("⚠️  Could not find firebase-adminsdk-key.json")
    print("Please download it from Firebase Console:")
    print("1. Go to Firebase Console > Project Settings")
    print("2. Click 'Service Accounts' tab")
    print("3. Click 'Generate New Private Key'")
    print("4. Save as 'firebase-adminsdk-key.json' in the scripts folder")
    exit(1)

db = firestore.client()

# Sample providers for Men's Hairstyles
providers = [
    {
        "serviceCategory": "Men's Hairstyles",
        "name": "Marcus Johnson",
        "businessName": "Elite Cuts Barbershop",
        "bio": "Master barber with 12 years of experience specializing in fades and modern men's styles. Certified in classic barbering techniques.",
        "profileImageURL": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
        "rating": 4.9,
        "reviewCount": 234,
        "priceRange": "$$",
        "specialties": ["Style 1", "Style 2"],  # Will update with actual style IDs
        "portfolioImages": [],
        "latitude": 37.7749,
        "longitude": -122.4194,
        "address": "123 Market Street",
        "city": "San Francisco",
        "state": "CA",
        "zipCode": "94102",
        "availability": ["Today 2PM", "Tomorrow 10AM", "Wed 3PM"]
    },
    {
        "serviceCategory": "Men's Hairstyles",
        "name": "David Chen",
        "businessName": "Precision Barber Studio",
        "bio": "Award-winning barber specializing in precision cuts and contemporary styles. Featured in Men's Style Magazine 2024.",
        "profileImageURL": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
        "rating": 4.8,
        "reviewCount": 189,
        "priceRange": "$$",
        "specialties": ["Style 1", "Style 2"],
        "portfolioImages": [],
        "latitude": 37.7849,
        "longitude": -122.4094,
        "address": "456 Valencia Street",
        "city": "San Francisco",
        "state": "CA",
        "zipCode": "94110",
        "availability": ["Today 4PM", "Tomorrow 1PM", "Fri 11AM"]
    },
    {
        "serviceCategory": "Men's Hairstyles",
        "name": "James Rodriguez",
        "businessName": "The Fade Factory",
        "bio": "Fade specialist with expertise in all fade variations. 8 years experience making clients look their best.",
        "profileImageURL": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400",
        "rating": 4.7,
        "reviewCount": 156,
        "priceRange": "$$",
        "specialties": ["Style 1", "Style 2"],
        "portfolioImages": [],
        "latitude": 37.7649,
        "longitude": -122.4294,
        "address": "789 Mission Street",
        "city": "San Francisco",
        "state": "CA",
        "zipCode": "94103",
        "availability": ["Tomorrow 9AM", "Thu 2PM", "Sat 10AM"]
    },
    {
        "serviceCategory": "Men's Hairstyles",
        "name": "Anthony Williams",
        "businessName": "Sharp Edge Barbershop",
        "bio": "Traditional barber offering classic cuts with a modern twist. Known for attention to detail and customer service.",
        "profileImageURL": "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400",
        "rating": 4.9,
        "reviewCount": 201,
        "priceRange": "$$",
        "specialties": ["Style 1", "Style 2"],
        "portfolioImages": [],
        "latitude": 37.7549,
        "longitude": -122.4394,
        "address": "321 Hayes Street",
        "city": "San Francisco",
        "state": "CA",
        "zipCode": "94102",
        "availability": ["Today 3PM", "Wed 10AM", "Fri 2PM"]
    },
    {
        "serviceCategory": "Men's Hairstyles",
        "name": "Tyler Jackson",
        "businessName": "Modern Man Barbershop",
        "bio": "Contemporary barbering with a focus on textured cuts and styling. Specializing in thick and curly hair.",
        "profileImageURL": "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400",
        "rating": 4.8,
        "reviewCount": 167,
        "priceRange": "$$$",
        "specialties": ["Style 2"],
        "portfolioImages": [],
        "latitude": 37.7949,
        "longitude": -122.3994,
        "address": "555 Castro Street",
        "city": "San Francisco",
        "state": "CA",
        "zipCode": "94114",
        "availability": ["Today 5PM", "Tomorrow 2PM", "Sat 1PM"]
    },
    {
        "serviceCategory": "Men's Hairstyles",
        "name": "Michael Torres",
        "businessName": "Classic Cuts & Shaves",
        "bio": "Old-school barbering meets modern style. Expert in traditional techniques and hot towel shaves.",
        "profileImageURL": "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=400",
        "rating": 4.9,
        "reviewCount": 312,
        "priceRange": "$$",
        "specialties": ["Style 1", "Style 2"],
        "portfolioImages": [],
        "latitude": 37.7449,
        "longitude": -122.4494,
        "address": "888 Divisadero Street",
        "city": "San Francisco",
        "state": "CA",
        "zipCode": "94115",
        "availability": ["Tomorrow 11AM", "Thu 3PM", "Sat 9AM"]
    }
]

print("🚀 Starting to add providers to Firestore...\n")

# First, get the actual style IDs from Firestore
print("📋 Fetching existing styles...")
styles_ref = db.collection("Men's Hairstyles")
styles = styles_ref.stream()

style_ids = []
for style in styles:
    style_ids.append(style.id)
    print(f"   Found style: {style.id} - {style.to_dict().get('name', 'Unknown')}")

if not style_ids:
    print("⚠️  No styles found in Firestore. Please add styles first.")
    exit(1)

print(f"\n✅ Found {len(style_ids)} styles\n")

# Update provider specialties with actual style IDs
for provider in providers:
    # Assign random styles from available styles
    if len(style_ids) >= 2:
        provider["specialties"] = style_ids[:2]  # First 2 styles
    else:
        provider["specialties"] = style_ids

# Add providers to Firestore
providers_ref = db.collection("providers")

for i, provider in enumerate(providers, 1):
    try:
        doc_ref = providers_ref.add(provider)
        print(f"✅ ({i}/{len(providers)}) Added: {provider['name']} at {provider['businessName']}")
        print(f"   Specialties: {provider['specialties']}")
    except Exception as e:
        print(f"❌ Error adding {provider['name']}: {str(e)}")

print(f"\n🎉 Successfully added {len(providers)} providers to Firestore!")
print("\n📍 All providers are located in San Francisco, CA")
print("💈 All providers specialize in Men's Hairstyles")
print("\n✨ You can now view these providers in your app!")

