# ⚡ Quick Start

## Run the App (3 Steps)

```bash
# 1. Navigate to project
cd "C:\Users\mufar\OneDrive\Desktop\mess logging app"

# 2. Get dependencies (already done!)
flutter pub get

# 3. Run the app
flutter run
```

**Select your device when prompted:**
- Windows (Desktop)
- Chrome (Web)
- Android (if connected)

## First Launch

1. **App opens to Calendar** ✅
2. **Tap today's date** 👆
3. **Select "Breakfast"** 🔵
4. **See the magic!** ✨

## 5-Minute Tutorial

### Minute 1: Log Some Meals
- Tap any date → Select meal type
- Try all three colors (Blue, Green, Orange)
- Notice how dates light up!

### Minute 2: Set Your Prices
- Bottom tab → Settings
- Enter your mess prices
- Tap "Save Prices"

### Minute 3: View Statistics
- Bottom tab → Statistics
- See your total bill
- Check the breakdowns

### Minute 4: Try Theme Toggle
- Top right icon → Toggle theme
- Enjoy dark mode!

### Minute 5: Explore
- Navigate months in Statistics
- Remove a meal log
- Add meals to different dates

## Common Commands

```bash
# Run on Chrome
flutter run -d chrome

# Run on Windows
flutter run -d windows

# Hot reload (while app is running)
Press 'r' in terminal

# Hot restart
Press 'R' in terminal

# Quit
Press 'q' in terminal

# Clean build
flutter clean
flutter pub get
flutter run
```

## Keyboard Shortcuts (While Running)

- `r` - Hot reload (fast updates)
- `R` - Hot restart (full restart)
- `h` - Help menu
- `q` - Quit app
- `d` - Detach (keep app running)

## Project Structure Quick Reference

```
lib/
├── main.dart              # App entry & navigation
├── models/                # Data structures
│   ├── meal_log.dart     # Meal log model
│   └── app_settings.dart # Settings model
├── services/              # Business logic
│   └── storage_service.dart  # Hive database
├── providers/             # State management
│   ├── meal_provider.dart    # Meal state
│   └── settings_provider.dart # Settings state
└── screens/               # UI pages
    ├── calendar_screen.dart   # Main logger
    ├── statistics_screen.dart # Analytics
    └── settings_screen.dart   # Configuration
```

## Quick Tips

### Calendar Screen
- **Single tap** = Log meal
- **Tap logged date** = Change or remove
- **Colors persist** = Data saved instantly

### Statistics Screen
- **Arrows** = Navigate months
- **Clear button** = Wipe month (careful!)
- **Updates live** = As you log meals

### Settings Screen
- **Enter prices** = Numbers only
- **Save** = Required after changes
- **Applies globally** = To all calculations

## Troubleshooting Quick Fixes

### App won't start?
```bash
flutter clean
flutter pub get
flutter run
```

### Linter errors?
```bash
flutter analyze
```

### Want fresh install?
```bash
# Delete app data
flutter clean

# Reinstall
flutter pub get
flutter run
```

## Build for Release

### Windows App
```bash
flutter build windows --release
# Find in: build/windows/x64/runner/Release/
```

### Android APK
```bash
flutter build apk --release
# Find in: build/app/outputs/flutter-apk/
```

### Web App
```bash
flutter build web --release
# Find in: build/web/
```

## File Sizes (Approximate)

- **Source Code:** ~50 KB
- **Dependencies:** ~30 MB
- **Built APK:** ~20 MB
- **Database:** < 1 MB (even with years of data)

## Performance Expectations

| Action | Expected Time |
|--------|--------------|
| App startup | < 2 seconds |
| Log a meal | Instant |
| Switch tabs | Instant |
| Save settings | < 100ms |
| Month navigation | Instant |
| Theme toggle | Instant |

## Getting Help

1. **Check README.md** - Full documentation
2. **Check FEATURES.md** - Feature details
3. **Check TESTING_GUIDE.md** - Test scenarios
4. **Check code comments** - Inline documentation

## Development Workflow

```bash
# 1. Make changes to code
# 2. Save files (Ctrl+S / Cmd+S)
# 3. Press 'r' in terminal (hot reload)
# 4. See changes instantly!
```

## Hot Reload vs Hot Restart

**Hot Reload (r):**
- Fast (< 1 second)
- Preserves app state
- Use for UI changes

**Hot Restart (R):**
- Slower (few seconds)
- Resets app state
- Use for state/logic changes

## Next Steps

1. ✅ Run the app
2. ✅ Test all features
3. ✅ Set your prices
4. ✅ Start logging meals!
5. 📊 Track your expenses
6. 💰 Save money!

---

**You're all set! Happy meal logging! 🍴**
