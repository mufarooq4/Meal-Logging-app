# Quick Setup Guide

## Step-by-Step Installation

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the App
```bash
flutter run
```

That's it! The app will launch directly to the calendar screen.

## First Time Usage

1. **Set Prices**
   - Go to Settings tab (bottom navigation)
   - Enter your mess prices:
     - Breakfast: Rs. 50 (default)
     - Lunch + Dinner: Rs. 100 (default)
     - Full Day: Rs. 150 (default)
   - Tap "Save Prices"

2. **Log Your First Meal**
   - Go to Calendar tab
   - Tap today's date
   - Select your meal type
   - See the date highlight with color!

3. **Check Statistics**
   - Go to Statistics tab
   - View your monthly breakdown
   - Track cumulative expenses

## Tips

- **Theme Toggle**: Tap the sun/moon icon in the top right
- **Delete Log**: Tap a logged date and select "Remove Log"
- **Clear Month**: Use "Clear Month Data" button in Statistics (careful!)
- **Navigate Months**: Use arrow buttons in Statistics to view different months

## Color Coding

- 🔵 **Blue** = Breakfast
- 🟢 **Green** = Lunch + Dinner  
- 🟠 **Orange** = Full Day Mess

## Common Issues

**Q: App crashes on startup?**  
A: Run `flutter clean` then `flutter pub get`

**Q: Calendar doesn't show colors?**  
A: Make sure you've selected a meal type for the date

**Q: Statistics show 0.00?**  
A: Log some meals first and ensure prices are set in Settings

## Development Commands

```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Run on specific device
flutter devices
flutter run -d <device-id>

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

## Project Structure Overview

- `lib/main.dart` - App entry point
- `lib/models/` - Data models
- `lib/services/` - Local storage logic
- `lib/providers/` - State management
- `lib/screens/` - UI pages

## Need Help?

Check the main README.md for detailed documentation!
