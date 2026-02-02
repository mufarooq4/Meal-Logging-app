import 'package:hive/hive.dart';

part 'meal_log.g.dart';

enum MealType {
  breakfast,
  lunchDinner,
  fullDay,
}

@HiveType(typeId: 0)
class MealLog extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final MealType mealType;

  MealLog({
    required this.date,
    required this.mealType,
  });

  String get dateKey => '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
