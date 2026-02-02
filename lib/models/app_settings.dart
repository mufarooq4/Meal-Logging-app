import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 1)
class AppSettings extends HiveObject {
  @HiveField(0)
  double breakfastPrice;

  @HiveField(1)
  double lunchDinnerPrice;

  @HiveField(2)
  double fullDayPrice;

  @HiveField(3)
  bool isDarkMode;

  AppSettings({
    this.breakfastPrice = 50.0,
    this.lunchDinnerPrice = 100.0,
    this.fullDayPrice = 150.0,
    this.isDarkMode = false,
  });
}
