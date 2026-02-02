import 'package:hive/hive.dart';

part 'date_alarm.g.dart';

@HiveType(typeId: 3)
class DateAlarm extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int hour;

  @HiveField(2)
  final int minute;

  @HiveField(3)
  final String message;

  DateAlarm({
    required this.date,
    required this.hour,
    required this.minute,
    this.message = 'Mess Out Time! Don\'t forget to log your meal.',
  });

  String get dateKey => '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  
  String get timeString => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  
  DateTime get scheduledDateTime => DateTime(
    date.year,
    date.month,
    date.day,
    hour,
    minute,
  );
}
