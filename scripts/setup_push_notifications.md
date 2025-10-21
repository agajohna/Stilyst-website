# Push Notifications Setup for Stilyst

## Xcode Project Configuration

### 1. Enable Push Notifications Capability

1. Open your project in Xcode
2. Select your target (Stilyst)
3. Go to "Signing & Capabilities" tab
4. Click "+ Capability"
5. Add "Push Notifications"

### 2. Add Background Modes

1. In "Signing & Capabilities" tab
2. Click "+ Capability" 
3. Add "Background Modes"
4. Check "Background processing"
5. Check "Remote notifications"

### 3. Update Bundle ID

Make sure your Bundle ID matches Firebase:
- **Current Bundle ID**: `com.stilyst`
- **Firebase Project ID**: `stilyst-2a5c4`

## Apple Developer Portal Setup

### 1. Create APNs Key

1. Go to https://developer.apple.com/account/
2. Navigate to "Certificates, Identifiers & Profiles"
3. Click "Keys" → "+"
4. Name: "Stilyst Firebase APNs Key"
5. Enable "Apple Push Notifications service (APNs)"
6. Download the `.p8` file
7. Save the Key ID and Team ID

### 2. Firebase Console Configuration

1. Go to https://console.firebase.google.com/project/stilyst-2a5c4
2. Project Settings → Cloud Messaging
3. Under "Apple app configuration":
   - Upload your `.p8` file
   - Enter Key ID
   - Enter Team ID
   - Save

## Testing

### Development Testing
- Phone auth will work in simulator
- Real device testing requires APNs setup

### Production Testing
- Must have valid APNs certificate
- Test with real phone numbers
- Verify SMS delivery

## Troubleshooting

### Common Issues:
1. **"Invalid APNs certificate"**: Check certificate upload in Firebase
2. **"Phone verification failed"**: Verify Bundle ID matches
3. **"No SMS received"**: Check APNs configuration

### Debug Steps:
1. Check Firebase Console for errors
2. Verify Bundle ID in Xcode matches Firebase
3. Test with different phone numbers
4. Check Apple Developer Portal for certificate status
