import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Get observer for navigation tracking
  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  // Log app open
  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  // Log meal logged event
  Future<void> logMealLogged(String mealType) async {
    await _analytics.logEvent(
      name: 'meal_logged',
      parameters: {
        'meal_type': mealType,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  // Log alarm set event
  Future<void> logAlarmSet(DateTime date) async {
    await _analytics.logEvent(
      name: 'alarm_set',
      parameters: {
        'date': date.toIso8601String(),
      },
    );
  }

  // Log theme toggle
  Future<void> logThemeToggled(bool isDarkMode) async {
    await _analytics.logEvent(
      name: 'theme_toggled',
      parameters: {
        'dark_mode': isDarkMode,
      },
    );
  }

  // Log price update
  Future<void> logPriceUpdated(String priceType, double value) async {
    await _analytics.logEvent(
      name: 'price_updated',
      parameters: {
        'price_type': priceType,
        'value': value,
      },
    );
  }

  // Log screen view
  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(
      screenName: screenName,
    );
  }

  // Log statistics viewed
  Future<void> logStatisticsViewed(String month, int year) async {
    await _analytics.logEvent(
      name: 'statistics_viewed',
      parameters: {
        'month': month,
        'year': year,
      },
    );
  }

  // Log data cleared
  Future<void> logDataCleared(String month, int year) async {
    await _analytics.logEvent(
      name: 'data_cleared',
      parameters: {
        'month': month,
        'year': year,
      },
    );
  }

  // Set user properties (optional)
  Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }
}
