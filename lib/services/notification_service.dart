import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  
  // Navigation key for handling notification responses
  static GlobalKey<NavigatorState>? navigatorKey;
  
  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    navigatorKey = key;
  }
  
  // Handle notification responses (when user taps notification or action buttons)
  void _handleNotificationResponse(NotificationResponse details) {
    debugPrint('📱 Notification Response:');
    debugPrint('   Action ID: ${details.actionId}');
    debugPrint('   Payload: ${details.payload}');
    
    if (details.payload == null || navigatorKey?.currentContext == null) {
      debugPrint('❌ No payload or context available');
      return;
    }
    
    try {
      final Map<String, dynamic> data = jsonDecode(details.payload!);
      final DateTime alarmDate = DateTime.parse(data['date']);
      final String message = data['message'] ?? 'Mess Out Reminder';
      final String actionId = details.actionId ?? 'tap';
      
      debugPrint('   Date: $alarmDate');
      debugPrint('   Message: $message');
      
      // Navigate to alarm response screen
      if (actionId != 'dismiss') {
        navigatorKey!.currentState?.push(
          MaterialPageRoute(
            builder: (context) {
              // Import the screen dynamically
              return _buildAlarmResponseScreen(alarmDate, message, actionId);
            },
          ),
        );
      } else {
        debugPrint('   ✅ Alarm dismissed');
      }
    } catch (e) {
      debugPrint('❌ Error handling notification response: $e');
    }
  }
  
  // Callback function to build alarm response screen (set from main.dart)
  static Widget Function(DateTime, String, String)? alarmResponseBuilder;
  
  static void setAlarmResponseBuilder(
    Widget Function(DateTime, String, String) builder,
  ) {
    alarmResponseBuilder = builder;
  }
  
  // Build the alarm response screen
  Widget _buildAlarmResponseScreen(DateTime date, String message, String actionId) {
    if (alarmResponseBuilder != null) {
      return alarmResponseBuilder!(date, message, actionId);
    }
    // Fallback if builder not set
    return Scaffold(
      appBar: AppBar(title: const Text('Alarm Response')),
      body: Center(
        child: Text('Action: $actionId\nDate: $date\nMessage: $message'),
      ),
    );
  }

  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize timezone database
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Karachi')); // Pakistan timezone

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    try {
      await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _handleNotificationResponse,
      );

      // Request permissions for Android 13+
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidPlugin = _notifications
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
        
        await androidPlugin?.requestNotificationsPermission();
        
        // Request exact alarm permission (required for Android 12+)
        await androidPlugin?.requestExactAlarmsPermission();
        
        // Create notification channel with alarm properties
        // IMPORTANT: Channel ID changed to 'meal_alarms_v2' to reset sound settings
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'meal_alarms_v2', // New channel ID to force sound reset
          'Meal Alarms',
          description: 'Alarms and reminders for meal logging',
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
          enableLights: true,
          showBadge: true,
        );
        
        await androidPlugin?.createNotificationChannel(channel);
        
        // Also create test notification channel
        const AndroidNotificationChannel testChannel = AndroidNotificationChannel(
          'test_notifications',
          'Test Alarms',
          description: 'Test alarm notifications',
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
          enableLights: true,
        );
        
        await androidPlugin?.createNotificationChannel(testChannel);
        
        debugPrint('✅ Alarm notification channels created');
      }

      _initialized = true;
      debugPrint('✅ Notification service initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing notifications: $e');
    }
  }

  Future<void> scheduleDateSpecificAlarm(
    DateTime date,
    int hour,
    int minute,
    String message,
  ) async {
    await initialize();

    // Create unique ID based on date
    final notificationId = _getNotificationId(date);

    final scheduledDate = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );

    final now = tz.TZDateTime.now(tz.local);
    
    // Only schedule if the time is in the future
    if (scheduledDate.isBefore(now)) {
      debugPrint('Scheduled time is in the past, not scheduling alarm');
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      'meal_alarms_v2', // Updated to match new channel ID
      'Meal Alarms',
      channelDescription: 'Alarms and reminders for meal logging',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.alarm,
      visibility: NotificationVisibility.public,
      styleInformation: BigTextStyleInformation(message),
      // Make it persistent until user responds
      ongoing: true,
      autoCancel: false,
      // Longer vibration pattern for more noticeable alarm
      vibrationPattern: Int64List.fromList([
        0, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 1000
      ]),
      // Add action buttons
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction(
          'confirmed_out',
          '✅ I\'m Out of Mess',
          showsUserInterface: true,
          cancelNotification: true,
        ),
        const AndroidNotificationAction(
          'remind_later',
          '⏰ Remind Me Later',
          showsUserInterface: true,
          cancelNotification: true,
        ),
        const AndroidNotificationAction(
          'dismiss',
          '❌ Dismiss',
          showsUserInterface: false,
          cancelNotification: true,
        ),
      ],
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'alarm.aiff',
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Create payload with alarm information
    final payload = jsonEncode({
      'date': date.toIso8601String(),
      'message': message,
      'hour': hour,
      'minute': minute,
    });

    try {
      await _notifications.zonedSchedule(
        notificationId,
        '🍴 Mess Out Reminder!',
        message,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );

      debugPrint('✅ ALARM SCHEDULED SUCCESSFULLY:');
      debugPrint('   📅 Date: ${scheduledDate.day}/${scheduledDate.month}/${scheduledDate.year}');
      debugPrint('   ⏰ Time: ${scheduledDate.hour.toString().padLeft(2, '0')}:${scheduledDate.minute.toString().padLeft(2, '0')}');
      debugPrint('   🆔 Notification ID: $notificationId');
      debugPrint('   💬 Message: $message');
      debugPrint('   ⏱️  Time until alarm: ${scheduledDate.difference(now).inMinutes} minutes');
      
      // Verify the alarm was scheduled
      final pending = await _notifications.pendingNotificationRequests();
      debugPrint('   📋 Total pending alarms: ${pending.length}');
      for (var p in pending) {
        debugPrint('      - ID: ${p.id}, Title: ${p.title}');
      }
    } catch (e) {
      debugPrint('❌ ERROR scheduling notification: $e');
      rethrow;
    }
  }

  Future<void> cancelDateSpecificAlarm(DateTime date) async {
    final notificationId = _getNotificationId(date);
    await _notifications.cancel(notificationId);
    debugPrint('Alarm cancelled for ${date.day}/${date.month}');
  }

  int _getNotificationId(DateTime date) {
    // Generate unique ID from date (format: YYYYMMDD as int)
    return int.parse('${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}');
  }

  Future<void> showImmediateNotification(String message) async {
    await initialize();

    final androidDetails = AndroidNotificationDetails(
      'test_notifications',
      'Test Notifications',
      channelDescription: 'Test notification channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      category: AndroidNotificationCategory.alarm,
      styleInformation: BigTextStyleInformation(message),
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      999999,
      '🍴 Test Notification',
      message,
      notificationDetails,
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
}
