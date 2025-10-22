# GitHub Pages Setup for stilyst.com

## 🚀 **Step-by-Step Setup**

### **1. Create GitHub Repository**
```bash
# Create a new repository called 'stilyst-website'
# Make it public (required for free GitHub Pages)
```

### **2. Upload Files**
Upload these files to your repository:
- ✅ `index.html` (main website)
- ✅ `privacy-policy.html` (privacy policy)
- ✅ `terms-of-service.html` (terms of service)
- ✅ `README.md` (repository description)
- ✅ `.github/workflows/deploy.yml` (auto-deployment)

### **3. Enable GitHub Pages**
1. Go to your repository **Settings**
2. Scroll down to **Pages** section
3. Under **Source**, select **GitHub Actions**
4. Your site will be available at `https://[username].github.io/stilyst-website`

### **4. Connect Custom Domain**
1. In **Pages** settings, add `stilyst.com` to **Custom domain**
2. GitHub will create a `CNAME` file automatically
3. Update your domain DNS settings:

**DNS Configuration:**
```
Type: CNAME
Name: www
Value: [username].github.io

Type: A
Name: @
Value: 185.199.108.153
Value: 185.199.109.153
Value: 185.199.110.153
Value: 185.199.111.153
```

### **5. SSL Certificate**
- GitHub automatically provides SSL certificates
- Enable **Enforce HTTPS** in Pages settings
- Your site will be available at `https://stilyst.com`

## 📁 **File Structure**
```
stilyst-website/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── index.html
├── privacy-policy.html
├── terms-of-service.html
└── README.md
```

## 🔧 **Customization**

### **Update Contact Information:**
In all HTML files, replace:
- `hello@stilyst.com` → Your actual email
- `privacy@stilyst.com` → Your privacy email
- `legal@stilyst.com` → Your legal email

### **Add Business Address:**
Update the contact sections with your actual business address.

### **App Store Links:**
Replace the placeholder download links with actual App Store URLs when your app is published.

## 🎯 **Pinterest Application**

### **Required URLs:**
- **Website**: `https://stilyst.com`
- **Privacy Policy**: `https://stilyst.com/privacy-policy.html`
- **Terms of Service**: `https://stilyst.com/terms-of-service.html`

### **Application Information:**
- **App Name**: Stilyst
- **App ID**: 1534611
- **Description**: Beauty services marketplace connecting clients with local professionals
- **Use Case**: Display trending beauty content from Pinterest to help users discover styles

## 🚀 **Deployment Process**

### **Automatic Deployment:**
- Push changes to `main` branch
- GitHub Actions automatically deploys
- Site updates within 2-3 minutes

### **Manual Deployment:**
- Go to **Actions** tab in your repository
- Click **Deploy to GitHub Pages**
- Wait for deployment to complete

## 📊 **Analytics (Optional)**

### **Google Analytics:**
Add this to the `<head>` section of `index.html`:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

## 🔒 **Security Features**

- ✅ **HTTPS**: Automatic SSL certificate
- ✅ **Security Headers**: GitHub Pages includes security headers
- ✅ **No Server**: Static site, no server vulnerabilities
- ✅ **CDN**: Global content delivery network

## 📱 **Mobile Optimization**

The website is fully responsive and optimized for:
- ✅ **Mobile devices** (iPhone, Android)
- ✅ **Tablets** (iPad, Android tablets)
- ✅ **Desktop** (all screen sizes)
- ✅ **Touch interactions** (mobile-friendly navigation)

## 🎉 **Benefits**

- ✅ **Free hosting** on GitHub Pages
- ✅ **Custom domain** support
- ✅ **Automatic SSL** certificates
- ✅ **CDN** for fast loading
- ✅ **Version control** with Git
- ✅ **Easy updates** through GitHub
- ✅ **Professional appearance** for Pinterest application

Your website will be live at `https://stilyst.com` and ready for Pinterest reapplication! 🚀
