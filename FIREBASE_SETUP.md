# 🔥 Firebase Analytics Setup Guide

## ✅ What's Already Done

1. ✅ **Firebase packages added** (`firebase_core`, `firebase_analytics`)
2. ✅ **FlutterFire CLI activated**
3. ✅ **Analytics Service created** (`lib/services/analytics_service.dart`)
4. ✅ **Main.dart updated** with Firebase imports (currently commented out)

---

## 📋 What You Need to Do

### **Step 1: Create a Firebase Project** 🌐

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project" or "Create a Project"
3. Enter project name: `meal-logging-app` (or your choice)
4. **Disable Google Analytics** if prompted (we'll add it manually)
5. Click "Create Project"
6. Wait for project creation to complete

### **Step 2: Configure Firebase for Your App** ⚙️

Run this command in your terminal:

```bash
cd "C:\Users\mufar\OneDrive\Desktop\mess logging app"
flutterfire configure
```

**What this will do:**
- Connect your Flutter app to your Firebase project
- Create `firebase_options.dart` file automatically
- Register your app for Android, iOS, Web platforms
- Download necessary configuration files

**During configuration:**
1. Select your Firebase project from the list
2. Choose platforms to support:
   - ✅ Android
   - ✅ iOS (if you plan to build for iOS later)
   - ⬜ Web (optional)
3. Wait for configuration to complete

### **Step 3: Enable Firebase Analytics in Console** 📊

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click on "Analytics" in the left sidebar
4. Click "Enable Google Analytics"
5. Create or select a Google Analytics account
6. Accept terms and enable

### **Step 4: Uncomment Code in main.dart** 📝

Open `lib/main.dart` and uncomment these lines:

**Line 5:** Uncomment the firebase_options import
```dart
import 'firebase_options.dart';
```

**Lines 23-26:** Uncomment Firebase initialization
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

**Line 33:** Uncomment app open logging
```dart
await analyticsService.logAppOpen();
```

**Lines 53-55:** Uncomment analytics observer
```dart
navigatorObservers: [
  analyticsService.getAnalyticsObserver(),
],
```

### **Step 5: Run the App** 🚀

```bash
flutter run -d emulator-5554
```

---

## 📊 What Analytics Will Track

Your app will automatically track:

### **Automatic Events:**
- ✅ **App Opens** - Every time user opens the app
- ✅ **Screen Views** - Which screens users visit
- ✅ **Session Duration** - How long users use the app
- ✅ **User Engagement** - Daily/Weekly/Monthly active users

### **Custom Events (Already Implemented):**
- 🍴 **Meal Logged** - When user logs a meal (with meal type)
- ⏰ **Alarm Set** - When user sets an alarm
- 🎨 **Theme Toggled** - Light/Dark mode changes
- 💰 **Price Updated** - When meal prices are changed
- 📊 **Statistics Viewed** - When user views statistics
- 🗑️ **Data Cleared** - When user clears month data

---

## 🎯 How to Add More Analytics

### Example: Track when user selects a date

In `lib/screens/calendar_screen.dart`, add:

```dart
import '../main.dart'; // For analyticsService

// In your date tap handler:
await analyticsService.logScreenView('calendar_date_selected');
```

### Example: Track meal deletion

```dart
await analyticsService.logEvent(
  name: 'meal_deleted',
  parameters: {
    'meal_type': mealType,
    'date': date.toIso8601String(),
  },
);
```

---

## 📈 View Your Analytics Data

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click "Analytics" → "Dashboard"
4. Wait 24 hours for initial data to appear

### Key Metrics to Monitor:
- **Active Users** (Daily/Weekly/Monthly)
- **Screens** (Most visited screens)
- **Events** (Most triggered events)
- **User Engagement** (Session duration, retention)
- **Demographics** (Country, language, device type)

---

## 🔒 Privacy & Data Collection

### What Firebase Analytics Collects:
- ✅ App usage patterns
- ✅ Device information (model, OS version)
- ✅ Geographic location (country/city level)
- ✅ Custom events you define

### What it DOES NOT collect:
- ❌ Personal meal data (encrypted locally)
- ❌ User names or emails
- ❌ Specific meal prices
- ❌ Alarm times

### GDPR Compliance:
- Analytics data is anonymous
- No PII (Personally Identifiable Information) is sent
- Users can opt-out (you can add this feature later)

---

## 🐛 Troubleshooting

### Problem: "firebase_options.dart not found"
**Solution:** Run `flutterfire configure` again

### Problem: "FirebaseException: No Firebase App"
**Solution:** Make sure Firebase.initializeApp() is called before runApp()

### Problem: "Analytics not showing data"
**Solution:** 
- Wait 24 hours for initial data
- Make sure Analytics is enabled in Firebase Console
- Check if app is in debug mode (some events filtered in debug)

### Problem: "FlutterFire CLI not found"
**Solution:** Add to PATH or use full path:
```bash
C:\Users\mufar\AppData\Local\Pub\Cache\bin\flutterfire configure
```

---

## 🎉 Success Checklist

- [ ] Firebase project created
- [ ] `flutterfire configure` completed successfully
- [ ] `firebase_options.dart` file exists
- [ ] All commented code in `main.dart` uncommented
- [ ] App builds without errors
- [ ] Analytics enabled in Firebase Console
- [ ] App running and logging events

---

## 📱 Testing Analytics

1. **Run the app** on your emulator
2. **Use the app:**
   - Log some meals
   - Set an alarm
   - Toggle theme
   - View statistics
   - Navigate between screens
3. **Check DebugView** (real-time):
   - Go to Firebase Console
   - Analytics → DebugView
   - You should see events in real-time
4. **Wait 24 hours** for dashboard data

---

## 💡 Pro Tips

1. **Enable Debug View** for real-time testing:
```bash
adb shell setprop debug.firebase.analytics.app com.example.meal_logging_app
```

2. **Disable Analytics in Development:**
```dart
await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
```

3. **Add User Properties:**
```dart
await analyticsService.setUserProperty('user_type', 'giki_student');
```

---

## 📚 Next Steps After Setup

1. **Test Analytics** using DebugView
2. **Monitor User Growth** in Firebase Dashboard
3. **Add Custom Events** for specific features
4. **Set up Crash Reporting** (Firebase Crashlytics)
5. **Add Remote Config** for A/B testing

---

**Need Help?**
- [Firebase Documentation](https://firebase.google.com/docs/flutter/setup)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Analytics Guide](https://firebase.google.com/docs/analytics)

---

**Your app is now ready for Firebase Analytics! 🚀**
Just complete Steps 1-5 above and you'll be tracking your app's usage!
