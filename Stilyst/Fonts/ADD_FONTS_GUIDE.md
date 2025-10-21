# How to Add Maison Neue Fonts to Xcode

## Step 1: Add Font Files to Project

1. Download Maison Neue font files (.ttf or .otf):
   - MaisonNeue-Book.ttf (Regular)
   - MaisonNeue-Light.ttf (Light)
   - MaisonNeue-Medium.ttf (Medium)
   - MaisonNeue-Bold.ttf (Bold)

2. In Xcode, drag the font files into the `Stilyst/Fonts/` folder
3. In the dialog:
   - ✅ Check "Copy items if needed"
   - ✅ Select "Stilyst" target
   - ✅ Click "Finish"

## Step 2: Add Fonts to Info.plist

You need to register the fonts in your Info.plist file. Since we don't have a separate Info.plist file, we'll add it to the project settings:

1. In Xcode, click on the **Stilyst** project in the navigator
2. Select the **Stilyst** target
3. Go to the **Info** tab
4. Under **Custom iOS Target Properties**, click the **+** button
5. Add a new entry:
   - Key: `Fonts provided by application`
   - Type: Array

6. Expand the array and add these items (click + for each):
   - Item 0: `MaisonNeue-Book.ttf`
   - Item 1: `MaisonNeue-Light.ttf`
   - Item 2: `MaisonNeue-Medium.ttf`
   - Item 3: `MaisonNeue-Bold.ttf`

## Step 3: Verify Font Names

The exact font names might be different from the file names. To verify:

1. Double-click a font file on your Mac (opens Font Book)
2. Look at the "PostScript name" - that's what you use in code
3. Common Maison Neue PostScript names:
   - `MaisonNeue-Book` (Regular)
   - `MaisonNeue-Light`
   - `MaisonNeue-Medium`
   - `MaisonNeue-Bold`

## Step 4: Test

1. Build and run the app
2. All text should now use Maison Neue
3. If you see the default system font, check:
   - Font files are in the project
   - Font names match PostScript names
   - Fonts are listed in Info.plist
   - Stilyst target is selected for the font files

## Alternative: Use SF Pro (Default)

If you don't have Maison Neue, the app will automatically fall back to SF Pro (iOS system font), which also looks great with the Soft Industrial color palette!

