# 🍴 Meal Logging App

A beautiful, local-first meal logging application designed for GIKI students to track their mess expenses.

## Features

✨ **Local-First Architecture** - All data stored securely on your device with Hive encryption  
📅 **Interactive Calendar** - Easy meal logging with visual color indicators  
📊 **Smart Statistics** - Monthly breakdowns and cumulative expense tracking  
⚙️ **Flexible Pricing** - Configure custom prices for different meal types  
🌓 **Theme Toggle** - Beautiful Light and Dark mode support  
🔒 **No Login Required** - Privacy-focused with zero cloud dependencies

## Tech Stack

- **Flutter** - Cross-platform UI framework
- **Provider** - State management
- **Hive** - Secure local storage with encryption
- **table_calendar** - Interactive calendar UI

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK

### Installation

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

## App Structure

```
lib/
├── models/              # Data models (MealLog, AppSettings)
├── services/            # Storage service (Hive integration)
├── providers/           # State management (MealProvider, SettingsProvider)
├── screens/             # UI screens
│   ├── calendar_screen.dart
│   ├── statistics_screen.dart
│   └── settings_screen.dart
└── main.dart           # App entry point
```

## Usage

### Logging Meals

1. Navigate to the **Calendar** tab
2. Tap any date on the calendar
3. Select meal type:
   - 🥞 **Breakfast** (Blue)
   - 🍽️ **Lunch + Dinner** (Green)
   - 🍱 **Full Day Mess** (Orange)
4. The date will highlight with the corresponding color

### Viewing Statistics

1. Go to the **Statistics** tab
2. Use arrows to navigate between months
3. View:
   - Total monthly bill
   - Meal type breakdowns
   - Average cost per day
   - Cumulative all-time expenses
4. Clear month data if needed (with confirmation)

### Configuring Prices

1. Open the **Settings** tab
2. Set prices for each meal type
3. Tap **Save Prices**
4. Changes apply immediately to all calculations

## Features in Detail

### Color-Coded Calendar
- **Blue** = Breakfast only
- **Green** = Lunch + Dinner
- **Orange** = Full Day Mess
- **Today** = Highlighted with a subtle background

### Statistics Dashboard
- Monthly bill calculations
- Detailed meal type counts
- Average daily cost analysis
- All-time cumulative tracking
- Month-wise data clearing

### Secure Storage
- Data encrypted with Hive
- No internet connection required
- No user accounts or cloud sync
- Complete privacy and control

## Customization

### Changing Default Prices

Edit default values in `lib/models/app_settings.dart`:

```dart
AppSettings({
  this.breakfastPrice = 50.0,      // Change these
  this.lunchDinnerPrice = 100.0,   // values as
  this.fullDayPrice = 150.0,       // needed
  this.isDarkMode = false,
})
```

### Theme Customization

Modify theme colors in `lib/main.dart`:

```dart
theme: ThemeData(
  primarySwatch: Colors.teal,  // Change primary color
  // ... other theme settings
),
```

## Building for Release

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Troubleshooting

### Issue: "Hive box already open"
**Solution:** Hot restart the app or clear app data

### Issue: Calendar not showing meals
**Solution:** Ensure storage service is initialized before providers

### Issue: Prices not saving
**Solution:** Check console for errors and ensure valid numeric input

## Contributing

This is a student project for GIKI. Feel free to fork and customize for your needs!

## License

MIT License - Free to use and modify

## Support

For issues or questions, please open an issue on the repository.

---

Made with ❤️ for GIKI Students
