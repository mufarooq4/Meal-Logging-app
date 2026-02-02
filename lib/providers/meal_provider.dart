import 'package:flutter/foundation.dart';
import '../models/meal_log.dart';
import '../services/storage_service.dart';

class MealProvider extends ChangeNotifier {
  final StorageService _storageService;
  Map<String, MealLog> _mealLogs = {};

  MealProvider(this._storageService) {
    _loadMealLogs();
    _listenToChanges();
  }

  Map<String, MealLog> get mealLogs => _mealLogs;

  void _loadMealLogs() {
    _mealLogs = _storageService.getAllMealLogs();
    notifyListeners();
  }

  void _listenToChanges() {
    _storageService.mealLogsStream.listen((_) {
      _loadMealLogs();
    });
  }

  Future<void> logMeal(DateTime date, MealType mealType) async {
    await _storageService.saveMealLog(date, mealType);
    _loadMealLogs();
  }

  MealLog? getMealForDate(DateTime date) {
    return _storageService.getMealLog(date);
  }

  Future<void> deleteMeal(DateTime date) async {
    await _storageService.deleteMealLog(date);
    _loadMealLogs();
  }

  List<MealLog> getMealLogsForMonth(int year, int month) {
    return _storageService.getMealLogsForMonth(year, month);
  }

  Future<void> clearMonthData(int year, int month) async {
    await _storageService.clearMonthData(year, month);
    _loadMealLogs();
  }

  // Statistics calculations
  Map<String, dynamic> getMonthStatistics(int year, int month, 
      {required double breakfastPrice, 
       required double lunchDinnerPrice, 
       required double fullDayPrice}) {
    final logs = getMealLogsForMonth(year, month);
    
    int breakfastCount = 0;
    int lunchDinnerCount = 0;
    int fullDayCount = 0;

    for (var log in logs) {
      switch (log.mealType) {
        case MealType.breakfast:
          breakfastCount++;
          break;
        case MealType.lunchDinner:
          lunchDinnerCount++;
          break;
        case MealType.fullDay:
          fullDayCount++;
          break;
      }
    }

    final totalBill = (breakfastCount * breakfastPrice) +
                      (lunchDinnerCount * lunchDinnerPrice) +
                      (fullDayCount * fullDayPrice);

    final totalDays = logs.length;
    final avgCostPerDay = totalDays > 0 ? totalBill / totalDays : 0.0;

    return {
      'breakfastCount': breakfastCount,
      'lunchDinnerCount': lunchDinnerCount,
      'fullDayCount': fullDayCount,
      'totalBill': totalBill,
      'totalDays': totalDays,
      'avgCostPerDay': avgCostPerDay,
    };
  }

  double getCumulativeAllTimeBill(
      {required double breakfastPrice, 
       required double lunchDinnerPrice, 
       required double fullDayPrice}) {
    double total = 0.0;
    
    for (var log in _mealLogs.values) {
      switch (log.mealType) {
        case MealType.breakfast:
          total += breakfastPrice;
          break;
        case MealType.lunchDinner:
          total += lunchDinnerPrice;
          break;
        case MealType.fullDay:
          total += fullDayPrice;
          break;
      }
    }
    
    return total;
  }
}
