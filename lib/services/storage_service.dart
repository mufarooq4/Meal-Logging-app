import 'package:hive_flutter/hive_flutter.dart';
import '../models/meal_log.dart';
import '../models/app_settings.dart';
import '../models/date_alarm.dart';

class StorageService {
  static const String _mealLogsBoxName = 'meal_logs';
  static const String _settingsBoxName = 'app_settings';
  static const String _dateAlarmsBoxName = 'date_alarms';

  late Box<MealLog> _mealBox;
  late Box<AppSettings> _settingsBox;
  late Box<DateAlarm> _dateAlarmsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MealLogAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(AppSettingsAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(MealTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(DateAlarmAdapter());
    }

    // Open boxes
    _mealBox = await Hive.openBox<MealLog>(_mealLogsBoxName);
    _settingsBox = await Hive.openBox<AppSettings>(_settingsBoxName);
    _dateAlarmsBox = await Hive.openBox<DateAlarm>(_dateAlarmsBoxName);

    // Initialize default settings if not exists
    if (_settingsBox.isEmpty) {
      await _settingsBox.put('settings', AppSettings());
    }
  }

  // Meal Log Operations
  Future<void> saveMealLog(DateTime date, MealType mealType) async {
    final dateKey = _getDateKey(date);
    final existingLog = _mealBox.get(dateKey);
    
    if (existingLog != null) {
      existingLog.delete();
    }
    
    final mealLog = MealLog(date: date, mealType: mealType);
    await _mealBox.put(dateKey, mealLog);
  }

  MealLog? getMealLog(DateTime date) {
    final dateKey = _getDateKey(date);
    return _mealBox.get(dateKey);
  }

  Future<void> deleteMealLog(DateTime date) async {
    final dateKey = _getDateKey(date);
    await _mealBox.delete(dateKey);
  }

  Map<String, MealLog> getAllMealLogs() {
    return Map<String, MealLog>.from(_mealBox.toMap());
  }

  // Get meal logs for a specific month
  List<MealLog> getMealLogsForMonth(int year, int month) {
    return _mealBox.values.where((log) {
      return log.date.year == year && log.date.month == month;
    }).toList();
  }

  // Clear month data
  Future<void> clearMonthData(int year, int month) async {
    final logsToDelete = getMealLogsForMonth(year, month);
    for (var log in logsToDelete) {
      await log.delete();
    }
  }

  // Settings Operations
  AppSettings getSettings() {
    return _settingsBox.get('settings') ?? AppSettings();
  }

  Future<void> updateSettings(AppSettings settings) async {
    await _settingsBox.put('settings', settings);
  }

  // Helper method
  String _getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Date Alarm Operations
  Future<void> saveDateAlarm(DateAlarm alarm) async {
    final dateKey = alarm.dateKey;
    await _dateAlarmsBox.put(dateKey, alarm);
  }

  DateAlarm? getDateAlarm(DateTime date) {
    final dateKey = _getDateKey(date);
    return _dateAlarmsBox.get(dateKey);
  }

  Future<void> deleteDateAlarm(DateTime date) async {
    final dateKey = _getDateKey(date);
    await _dateAlarmsBox.delete(dateKey);
  }

  Map<String, DateAlarm> getAllDateAlarms() {
    return Map<String, DateAlarm>.from(_dateAlarmsBox.toMap());
  }

  List<DateAlarm> getUpcomingAlarms() {
    final now = DateTime.now();
    return _dateAlarmsBox.values.where((alarm) {
      return alarm.scheduledDateTime.isAfter(now);
    }).toList()..sort((a, b) => a.scheduledDateTime.compareTo(b.scheduledDateTime));
  }

  // Listen to changes
  Stream<BoxEvent> get mealLogsStream => _mealBox.watch();
  Stream<BoxEvent> get settingsStream => _settingsBox.watch();
  Stream<BoxEvent> get dateAlarmsStream => _dateAlarmsBox.watch();
}
