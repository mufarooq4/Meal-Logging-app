import 'package:flutter/foundation.dart';
import '../models/date_alarm.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import '../services/haptic_service.dart';

class AlarmProvider extends ChangeNotifier {
  final StorageService _storageService;
  final NotificationService _notificationService = NotificationService();
  final HapticService _hapticService = HapticService();
  Map<String, DateAlarm> _dateAlarms = {};

  AlarmProvider(this._storageService) {
    _loadAlarms();
    _listenToChanges();
    _initializeServices();
  }

  Map<String, DateAlarm> get dateAlarms => _dateAlarms;

  Future<void> _initializeServices() async {
    await _notificationService.initialize();
    await _hapticService.initialize();
  }

  void _loadAlarms() {
    _dateAlarms = _storageService.getAllDateAlarms();
    notifyListeners();
  }

  void _listenToChanges() {
    _storageService.dateAlarmsStream.listen((_) {
      _loadAlarms();
    });
  }

  DateAlarm? getAlarmForDate(DateTime date) {
    return _storageService.getDateAlarm(date);
  }

  Future<void> setAlarm(
    DateTime date,
    int hour,
    int minute,
    String message,
  ) async {
    final alarm = DateAlarm(
      date: date,
      hour: hour,
      minute: minute,
      message: message,
    );

    await _storageService.saveDateAlarm(alarm);
    
    // Schedule notification
    await _notificationService.scheduleDateSpecificAlarm(
      date,
      hour,
      minute,
      message,
    );

    await _hapticService.success();
    _loadAlarms();
  }

  Future<void> deleteAlarm(DateTime date) async {
    await _storageService.deleteDateAlarm(date);
    await _notificationService.cancelDateSpecificAlarm(date);
    await _hapticService.warning();
    _loadAlarms();
  }

  List<DateAlarm> getUpcomingAlarms() {
    return _storageService.getUpcomingAlarms();
  }

  Future<void> testAlarm(String message) async {
    await _notificationService.showImmediateNotification(message);
    await _hapticService.success();
  }

  // Clean up old alarms (past dates)
  Future<void> cleanupOldAlarms() async {
    final now = DateTime.now();
    final oldAlarms = _dateAlarms.values.where((alarm) {
      return alarm.scheduledDateTime.isBefore(now);
    }).toList();

    for (var alarm in oldAlarms) {
      await deleteAlarm(alarm.date);
    }
  }
}
