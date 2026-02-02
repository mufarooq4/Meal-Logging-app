# 🏗️ App Architecture

## Visual Overview

```
┌─────────────────────────────────────────────────────────┐
│                   🍴 Meal Logging App                   │
│                                                         │
│  ┌─────────────────────────────────────────────────┐  │
│  │              App Bar (Theme Toggle)              │  │
│  └─────────────────────────────────────────────────┘  │
│                                                         │
│  ┌─────────────────────────────────────────────────┐  │
│  │                                                 │  │
│  │              📅 CALENDAR SCREEN                 │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │   Interactive Table Calendar          │   │  │
│  │   │                                        │   │  │
│  │   │   🔵 Blue    = Breakfast               │   │  │
│  │   │   🟢 Green   = Lunch + Dinner          │   │  │
│  │   │   🟠 Orange  = Full Day Mess           │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │              ▼ Tap Date ▼                      │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │      Bottom Sheet (Meal Selector)     │   │  │
│  │   │  • Breakfast (Blue)                   │   │  │
│  │   │  • Lunch + Dinner (Green)             │   │  │
│  │   │  • Full Day Mess (Orange)             │   │  │
│  │   │  • Remove Log (if exists)             │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  └─────────────────────────────────────────────────┘  │
│                                                         │
│  OR                                                     │
│                                                         │
│  ┌─────────────────────────────────────────────────┐  │
│  │                                                 │  │
│  │             📊 STATISTICS SCREEN               │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │    ◀ Feb 2026 ▶ (Month Selector)     │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │   💰 Total Bill for February          │   │  │
│  │   │        Rs. 4,500.00                   │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │ 🔵 Total Breakfasts: 15              │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │ 🟢 Total Lunch + Dinner: 20          │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │ 🟠 Total Full Day Mess: 5            │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │      📈 Monthly Summary               │   │  │
│  │   │  • Total Days Logged: 28             │   │  │
│  │   │  • Avg Cost Per Day: Rs. 160.71      │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │ 💎 Cumulative All-Time Bill           │   │  │
│  │   │        Rs. 45,000.00                  │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │    🗑️ Clear Month Data (Button)      │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  └─────────────────────────────────────────────────┘  │
│                                                         │
│  OR                                                     │
│                                                         │
│  ┌─────────────────────────────────────────────────┐  │
│  │                                                 │  │
│  │              ⚙️ SETTINGS SCREEN                │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │      💰 Price Configuration           │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │ 🔵 Breakfast Price                    │   │  │
│  │   │    Rs. [____50.00____]               │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │ 🟢 Lunch + Dinner Price               │   │  │
│  │   │    Rs. [___100.00____]               │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │ 🟠 Full Day Mess Price                │   │  │
│  │   │    Rs. [___150.00____]               │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │   ┌───────────────────────────────────────┐   │  │
│  │   │     💾 Save Prices (Button)           │   │  │
│  │   └───────────────────────────────────────┘   │  │
│  │                                                 │  │
│  │   ℹ️ These prices calculate your statistics   │  │
│  │                                                 │  │
│  └─────────────────────────────────────────────────┘  │
│                                                         │
│  ┌─────────────────────────────────────────────────┐  │
│  │         Bottom Navigation Bar                   │  │
│  │   📅 Calendar  |  📊 Statistics  |  ⚙️ Settings │  │
│  └─────────────────────────────────────────────────┘  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Data Flow Architecture

```
┌──────────────────────────────────────────────────────┐
│                    USER ACTIONS                      │
│  • Tap date                                          │
│  • Select meal type                                  │
│  • Change settings                                   │
│  • Toggle theme                                      │
│  • Navigate tabs                                     │
└───────────────────┬──────────────────────────────────┘
                    ↓
┌───────────────────────────────────────────────────────┐
│                 UI LAYER (Screens)                    │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐   │
│  │  Calendar   │ │ Statistics  │ │  Settings   │   │
│  │   Screen    │ │   Screen    │ │   Screen    │   │
│  └──────┬──────┘ └──────┬──────┘ └──────┬──────┘   │
│         │                │                │           │
│         └────────────────┼────────────────┘           │
└──────────────────────────┼──────────────────────────┘
                           ↓
┌───────────────────────────────────────────────────────┐
│           STATE MANAGEMENT (Providers)                │
│  ┌─────────────────────┐  ┌──────────────────────┐  │
│  │   MealProvider      │  │  SettingsProvider    │  │
│  │  • Meal logs        │  │  • Prices            │  │
│  │  • Statistics       │  │  • Theme             │  │
│  │  • Calculations     │  │  • Preferences       │  │
│  └──────────┬──────────┘  └──────────┬───────────┘  │
│             │                         │               │
│             └────────────┬────────────┘               │
└──────────────────────────┼──────────────────────────┘
                           ↓
┌───────────────────────────────────────────────────────┐
│            BUSINESS LOGIC (Service)                   │
│  ┌──────────────────────────────────────────────┐   │
│  │          StorageService                      │   │
│  │  • saveMealLog()                            │   │
│  │  • getMealLog()                             │   │
│  │  • deleteMealLog()                          │   │
│  │  • getMealLogsForMonth()                    │   │
│  │  • clearMonthData()                         │   │
│  │  • getSettings()                            │   │
│  │  • updateSettings()                         │   │
│  └──────────────────┬───────────────────────────┘   │
└─────────────────────┼───────────────────────────────┘
                      ↓
┌───────────────────────────────────────────────────────┐
│         DATA PERSISTENCE (Hive Database)              │
│  ┌──────────────────┐      ┌──────────────────┐     │
│  │  meal_logs Box   │      │  app_settings    │     │
│  │  (MealLog)       │      │  Box (Settings)  │     │
│  │                  │      │                  │     │
│  │  • Date key      │      │  • Prices        │     │
│  │  • Meal type     │      │  • Theme mode    │     │
│  └──────────────────┘      └──────────────────┘     │
│                                                       │
│         📱 Local Device Storage (Encrypted)          │
└───────────────────────────────────────────────────────┘
                      ↑
                      │
                      ↓
            ┌─────────────────┐
            │   REACTIVE UI   │
            │  Auto-updates   │
            │  when data      │
            │  changes        │
            └─────────────────┘
```

## Component Interaction

```
main.dart
  │
  ├─→ Initialize Hive Storage
  │     │
  │     └─→ StorageService.init()
  │           │
  │           ├─→ Register MealLog adapter
  │           ├─→ Register AppSettings adapter
  │           ├─→ Register MealType adapter
  │           ├─→ Open meal_logs box
  │           └─→ Open app_settings box
  │
  ├─→ Create Providers
  │     │
  │     ├─→ SettingsProvider(storageService)
  │     │     │
  │     │     ├─→ Load settings from Hive
  │     │     ├─→ Listen to settings changes
  │     │     └─→ Provide: isDarkMode, prices
  │     │
  │     └─→ MealProvider(storageService)
  │           │
  │           ├─→ Load all meal logs
  │           ├─→ Listen to meal log changes
  │           └─→ Provide: logs, statistics
  │
  ├─→ Build App with Theme
  │     │
  │     └─→ Consumer<SettingsProvider>
  │           │
  │           └─→ Apply theme based on isDarkMode
  │
  └─→ HomePage with Bottom Navigation
        │
        ├─→ Tab 0: CalendarScreen
        │     │
        │     ├─→ Display TableCalendar
        │     ├─→ Color cells based on meal logs
        │     ├─→ On date tap → Show meal selector
        │     └─→ Save to MealProvider
        │
        ├─→ Tab 1: StatisticsScreen
        │     │
        │     ├─→ Month selector (arrows)
        │     ├─→ Get statistics from MealProvider
        │     ├─→ Display:
        │     │     • Total bill card
        │     │     • Meal count cards
        │     │     • Monthly summary
        │     │     • All-time bill
        │     └─→ Clear month data button
        │
        └─→ Tab 2: SettingsScreen
              │
              ├─→ Display price input fields
              ├─→ Validate input
              └─→ Save to SettingsProvider
```

## State Management Flow

```
User logs a meal:
  Calendar Screen → Tap Date
         ↓
  Show Bottom Sheet → Select Meal Type
         ↓
  mealProvider.logMeal(date, type)
         ↓
  storageService.saveMealLog(date, type)
         ↓
  Hive saves to local database
         ↓
  Hive notifies listeners (stream)
         ↓
  MealProvider reloads data
         ↓
  notifyListeners()
         ↓
  All consuming widgets rebuild:
    • Calendar Screen (colors update)
    • Statistics Screen (numbers update)
```

```
User changes price:
  Settings Screen → Enter New Price
         ↓
  Tap Save Button
         ↓
  settingsProvider.updatePrices(...)
         ↓
  storageService.updateSettings(settings)
         ↓
  Hive saves to local database
         ↓
  Hive notifies listeners (stream)
         ↓
  SettingsProvider reloads data
         ↓
  notifyListeners()
         ↓
  All consuming widgets rebuild:
    • Statistics Screen (recalculates bills)
    • Settings Screen (confirms save)
```

```
User toggles theme:
  App Bar → Tap Theme Icon
         ↓
  settingsProvider.toggleTheme()
         ↓
  Update isDarkMode in settings
         ↓
  storageService.updateSettings(settings)
         ↓
  Hive saves preference
         ↓
  notifyListeners()
         ↓
  MaterialApp rebuilds with new theme
         ↓
  Entire app switches theme smoothly
```

## File Dependency Graph

```
main.dart
  ├─→ services/storage_service.dart
  │     ├─→ hive/hive_flutter
  │     ├─→ models/meal_log.dart
  │     └─→ models/app_settings.dart
  │
  ├─→ providers/settings_provider.dart
  │     ├─→ flutter/foundation (ChangeNotifier)
  │     ├─→ services/storage_service.dart
  │     └─→ models/app_settings.dart
  │
  ├─→ providers/meal_provider.dart
  │     ├─→ flutter/foundation (ChangeNotifier)
  │     ├─→ services/storage_service.dart
  │     └─→ models/meal_log.dart
  │
  ├─→ screens/calendar_screen.dart
  │     ├─→ flutter/material
  │     ├─→ provider
  │     ├─→ table_calendar
  │     ├─→ models/meal_log.dart
  │     └─→ providers/meal_provider.dart
  │
  ├─→ screens/statistics_screen.dart
  │     ├─→ flutter/material
  │     ├─→ provider
  │     ├─→ providers/meal_provider.dart
  │     └─→ providers/settings_provider.dart
  │
  └─→ screens/settings_screen.dart
        ├─→ flutter/material
        ├─→ provider
        └─→ providers/settings_provider.dart
```

## Database Schema

```
Hive Database
│
├─→ meal_logs Box (Type: MealLog)
│   │
│   ├─→ Key: "2026-02-01"
│   │   Value: MealLog {
│   │     date: DateTime(2026, 2, 1),
│   │     mealType: MealType.breakfast
│   │   }
│   │
│   ├─→ Key: "2026-02-02"
│   │   Value: MealLog {
│   │     date: DateTime(2026, 2, 2),
│   │     mealType: MealType.fullDay
│   │   }
│   │
│   └─→ ... (one entry per logged date)
│
└─→ app_settings Box (Type: AppSettings)
    │
    └─→ Key: "settings"
        Value: AppSettings {
          breakfastPrice: 50.0,
          lunchDinnerPrice: 100.0,
          fullDayPrice: 150.0,
          isDarkMode: false
        }
```

## Type System

```
Enums:
  MealType
    ├─→ breakfast
    ├─→ lunchDinner
    └─→ fullDay

Models:
  MealLog (HiveObject)
    ├─→ date: DateTime
    └─→ mealType: MealType

  AppSettings (HiveObject)
    ├─→ breakfastPrice: double
    ├─→ lunchDinnerPrice: double
    ├─→ fullDayPrice: double
    └─→ isDarkMode: bool

Providers:
  MealProvider (ChangeNotifier)
    ├─→ mealLogs: Map<String, MealLog>
    ├─→ Methods: logMeal, getMealForDate, etc.
    └─→ Calculations: statistics, bills

  SettingsProvider (ChangeNotifier)
    ├─→ settings: AppSettings
    ├─→ Getters: prices, isDarkMode
    └─→ Methods: updatePrices, toggleTheme
```

## Navigation Structure

```
App Root (MaterialApp)
  │
  └─→ HomePage (Scaffold)
        │
        ├─→ AppBar
        │     ├─→ Title: "🍴 Meal Logging"
        │     └─→ Action: Theme Toggle Button
        │
        ├─→ Body: IndexedStack[_currentIndex]
        │     │
        │     ├─→ [0] CalendarScreen
        │     ├─→ [1] StatisticsScreen
        │     └─→ [2] SettingsScreen
        │
        └─→ BottomNavigationBar
              ├─→ [0] Calendar (icon: calendar_month)
              ├─→ [1] Statistics (icon: bar_chart)
              └─→ [2] Settings (icon: settings)
```

## Event Flow Examples

### Example 1: First Time User
```
1. App Launch
     ↓
2. Hive initializes → No data found
     ↓
3. Default settings created automatically
     ↓
4. Calendar screen shows → Empty calendar
     ↓
5. User taps today's date
     ↓
6. Bottom sheet appears → 3 meal options
     ↓
7. User selects "Breakfast"
     ↓
8. Data saved to Hive instantly
     ↓
9. Calendar cell turns blue
     ↓
10. User goes to Statistics → Shows Rs. 50.00
```

### Example 2: Changing Price
```
1. User at Settings screen
     ↓
2. Changes Breakfast: 50 → 75
     ↓
3. Taps "Save Prices"
     ↓
4. Validation passes → Positive number
     ↓
5. SettingsProvider updates
     ↓
6. Hive saves new price
     ↓
7. Success snackbar shows
     ↓
8. User switches to Statistics
     ↓
9. Bills automatically recalculated
     ↓
10. New total displayed
```

### Example 3: Monthly Review
```
1. User opens app (mid-month)
     ↓
2. Has logged 15 meals this month
     ↓
3. Navigates to Statistics tab
     ↓
4. Sees current month (Feb 2026)
     ↓
5. Total Bill: Rs. 1,500
     ↓
6. Breakdown:
    • 10 Breakfasts = Rs. 500
    • 5 Lunch+Dinners = Rs. 1,000
     ↓
7. Monthly Summary:
    • 15 days logged
    • Avg: Rs. 100/day
     ↓
8. Satisfied with review
     ↓
9. Goes back to Calendar to log today
```

## Performance Optimizations

```
✅ Lazy Loading
   - Providers initialize only when needed
   - Hive boxes opened once at startup

✅ Efficient Queries
   - Date-based keys for O(1) lookup
   - Month filtering done in-memory
   - No network latency

✅ Smart Rebuilds
   - Provider only notifies on actual changes
   - Widgets rebuild selectively
   - No unnecessary recalculations

✅ Local Storage
   - Hive is extremely fast (native speed)
   - Binary format = small size
   - No serialization overhead

✅ Minimal Dependencies
   - Only essential packages
   - No bloated libraries
   - Fast compile times
```

## Security Considerations

```
✅ Local-First
   - No data sent to servers
   - No API calls
   - No authentication needed

✅ Hive Encryption (Ready)
   - Can enable with encryption key
   - Transparent encryption/decryption
   - Secure key storage recommended

✅ Input Validation
   - Price inputs validated
   - Negative values rejected
   - Non-numeric inputs handled

✅ No External Dependencies
   - No tracking
   - No analytics
   - No ads
   - Complete privacy
```

---

This architecture provides:
- 🚀 Fast performance
- 🔒 Complete privacy
- 📱 Offline-first
- 🎨 Clean code
- 🧩 Easy maintenance
- 📈 Scalable design

**Perfect for a student meal logging app!** 🍴
