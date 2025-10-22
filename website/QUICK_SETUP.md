# Quick Setup for stilyst.com

## 🚀 **One-Command Setup**

```bash
cd website
./setup.sh
```

## 📋 **Manual Steps**

### **1. Create GitHub Repository**
1. Go to [github.com/new](https://github.com/new)
2. Repository name: `stilyst-website`
3. Make it **Public** (required for free GitHub Pages)
4. Click **Create repository**

### **2. Push to GitHub**
```bash
cd website
git remote add origin https://github.com/YOUR_USERNAME/stilyst-website.git
git push -u origin main
```

### **3. Enable GitHub Pages**
1. Go to repository **Settings**
2. Scroll to **Pages** section
3. Source: **GitHub Actions**
4. Your site will be at `https://YOUR_USERNAME.github.io/stilyst-website`

### **4. Connect Custom Domain**
1. In **Pages** settings, add `stilyst.com`
2. GitHub creates `CNAME` file automatically
3. Update your domain DNS:

**DNS Settings:**
```
Type: CNAME
Name: www
Value: YOUR_USERNAME.github.io

Type: A
Name: @
Value: 185.199.108.153
Value: 185.199.109.153
Value: 185.199.110.153
Value: 185.199.111.153
```

### **5. Enable HTTPS**
- Check **Enforce HTTPS** in Pages settings
- Your site will be live at `https://stilyst.com`

## ✅ **What You Get**

- ✅ **Professional website** at `https://stilyst.com`
- ✅ **Privacy policy** at `https://stilyst.com/privacy-policy.html`
- ✅ **Terms of service** at `https://stilyst.com/terms-of-service.html`
- ✅ **Mobile responsive** design
- ✅ **SEO optimized** for search engines
- ✅ **Free hosting** on GitHub Pages
- ✅ **Automatic SSL** certificate
- ✅ **Global CDN** for fast loading

## 🎯 **For Pinterest Application**

**Required URLs:**
- Website: `https://stilyst.com`
- Privacy Policy: `https://stilyst.com/privacy-policy.html`
- Terms of Service: `https://stilyst.com/terms-of-service.html`

**Application Info:**
- App Name: Stilyst
- App ID: 1534611
- Description: Beauty services marketplace connecting clients with local professionals
- Use Case: Display trending beauty content from Pinterest

## 🔧 **Customization**

**Update contact info in HTML files:**
- Replace `hello@stilyst.com` with your email
- Add your business address
- Update app store links when published

## 📱 **Features**

- **Responsive design** works on all devices
- **Professional styling** with your brand colors
- **Fast loading** with optimized code
- **SEO friendly** with proper meta tags
- **Mobile navigation** with hamburger menu
- **Contact forms** ready for integration

Your website will be live and ready for Pinterest reapplication! 🎉
