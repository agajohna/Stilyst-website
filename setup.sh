#!/bin/bash

# Stilyst Website Setup Script
echo "🚀 Setting up Stilyst website for GitHub Pages..."

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found. Please run this script from the website directory."
    exit 1
fi

echo "✅ Website files found"

# Create .gitignore
cat > .gitignore << EOF
# macOS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
EOF

echo "✅ Created .gitignore"

# Initialize git repository
if [ ! -d ".git" ]; then
    git init
    echo "✅ Initialized Git repository"
else
    echo "✅ Git repository already exists"
fi

# Add all files
git add .
echo "✅ Added files to Git"

# Create initial commit
git commit -m "Initial commit: Stilyst website

✅ Professional landing page
✅ Privacy policy and terms of service
✅ GitHub Pages configuration
✅ Responsive design
✅ SEO optimized

Ready for deployment to stilyst.com"
echo "✅ Created initial commit"

echo ""
echo "🎉 Website setup complete!"
echo ""
echo "Next steps:"
echo "1. Create a new repository on GitHub called 'stilyst-website'"
echo "2. Run: git remote add origin https://github.com/YOUR_USERNAME/stilyst-website.git"
echo "3. Run: git push -u origin main"
echo "4. Enable GitHub Pages in repository settings"
echo "5. Add custom domain 'stilyst.com'"
echo "6. Update DNS settings as per GITHUB_PAGES_SETUP.md"
echo ""
echo "Your website will be live at https://stilyst.com"
