# Social Media Integration Setup Guide

## 🎯 Overview
This guide will help you set up Pinterest and Instagram API integration to populate your Stilyst app with real trending content.

## 📌 Pinterest API Setup

### 1. Create Pinterest Developer Account
1. Go to [Pinterest Developers](https://developers.pinterest.com/)
2. Sign in with your Pinterest account
3. Create a new app
4. Get your **App ID** and **App Secret**

### 2. Pinterest API Configuration
```swift
// In your app configuration
let pinterestApiKey = "YOUR_PINTEREST_API_KEY"
let socialContentManager = SocialContentManager(pinterestApiKey: pinterestApiKey)
```

### 3. Pinterest API Endpoints Used
- **Search Pins**: `/v5/search/pins`
- **Pin Details**: `/v5/pins/{pin_id}`
- **User Boards**: `/v5/boards`

### 4. Pinterest Search Queries
- Men's Hairstyles: `mens+hairstyles+trending+2024`
- Women's Hairstyles: `womens+hairstyles+trending+2024`
- Nails: `nail+art+trending+2024`
- Makeup: `makeup+trending+2024`

## 📸 Instagram API Setup

### 1. Facebook Developer Account
1. Go to [Facebook Developers](https://developers.facebook.com/)
2. Create a new app
3. Add Instagram Basic Display product
4. Get your **App ID** and **App Secret**

### 2. Instagram Business Account
1. Convert your Instagram to Business account
2. Connect to Facebook Page
3. Get **Access Token** from Facebook Graph API

### 3. Instagram API Configuration
```swift
// In your app configuration
let instagramAccessToken = "YOUR_INSTAGRAM_ACCESS_TOKEN"
let socialContentManager = SocialContentManager(instagramAccessToken: instagramAccessToken)
```

### 4. Instagram Hashtag IDs
- Men's Hairstyles: `#menshairstyles`
- Women's Hairstyles: `#womenshairstyles`
- Nails: `#nailart`
- Makeup: `#makeup`

## 🔧 Implementation Steps

### 1. Add API Keys to Your App
```swift
// In StilystApp.swift or a configuration file
let pinterestApiKey = "YOUR_PINTEREST_API_KEY"
let instagramAccessToken = "YOUR_INSTAGRAM_ACCESS_TOKEN"

let socialContentManager = SocialContentManager(
    pinterestApiKey: pinterestApiKey,
    instagramAccessToken: instagramAccessToken
)
```

### 2. Update StyleService
```swift
// In StyleService.swift
func fetchTrendingStyles(for category: ServiceCategory, completion: @escaping ([Style]) -> Void) {
    // First try social media content
    socialContentManager.fetchTrendingContent(for: category) { socialStyles in
        if !socialStyles.isEmpty {
            completion(socialStyles)
        } else {
            // Fallback to manual content
            self.fetchLocalTrendingStyles(for: category, completion: completion)
        }
    }
}
```

### 3. Add Social Media Indicators
The app now shows:
- 🔥 **Trending** badge for popular content
- 📌 **Pinterest** badge for Pinterest-sourced content
- 📸 **Instagram** badge for Instagram-sourced content

## 📊 Content Features

### Social Metrics Integration
- **Likes**: Pinterest saves, Instagram likes
- **Comments**: User engagement
- **Shares**: Social sharing
- **Saves**: Pinterest saves
- **Engagement Score**: Calculated trending score

### Trending Algorithm
```swift
var trendingScore: Int {
    let baseScore = viewCount + (bookingCount * 10)
    let socialScore = socialMetrics?.engagementScore ?? 0
    return baseScore + socialScore
}
```

## 🚀 Benefits

### For Users
- ✅ **Real trending content** from social media
- ✅ **Up-to-date styles** that are actually popular
- ✅ **Social proof** with engagement metrics
- ✅ **Source attribution** showing where content comes from

### For Providers
- ✅ **Current trends** to offer clients
- ✅ **Social media inspiration** for their work
- ✅ **Engagement data** to understand what's popular

## 🔒 Privacy & Legal Considerations

### Content Usage
- ✅ **Attribution**: All content shows source and author
- ✅ **Links**: Direct links to original posts
- ✅ **Respect**: Proper attribution to creators

### API Compliance
- ✅ **Rate Limits**: Respect API rate limits
- ✅ **Terms of Service**: Follow platform guidelines
- ✅ **User Privacy**: Protect user data

## 🛠️ Troubleshooting

### Common Issues
1. **API Key Invalid**: Check your API credentials
2. **Rate Limit Exceeded**: Implement proper rate limiting
3. **Content Not Loading**: Check network connectivity
4. **Authentication Failed**: Verify OAuth tokens

### Fallback Strategy
If social media APIs fail, the app automatically falls back to:
- Manual content from Firebase
- Cached trending content
- Default placeholder content

## 📈 Next Steps

1. **Set up API accounts** (Pinterest + Instagram)
2. **Get API keys** and access tokens
3. **Configure the app** with your credentials
4. **Test integration** with different categories
5. **Monitor performance** and engagement

This integration will make your Stilyst app a true reflection of what's trending in beauty right now! 🎨✨
