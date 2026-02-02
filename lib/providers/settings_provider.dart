import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';
import '../services/storage_service.dart';

class SettingsProvider extends ChangeNotifier {
  final StorageService _storageService;
  late AppSettings _settings;

  SettingsProvider(this._storageService) {
    _loadSettings();
    _listenToChanges();
  }

  AppSettings get settings => _settings;
  bool get isDarkMode => _settings.isDarkMode;
  double get breakfastPrice => _settings.breakfastPrice;
  double get lunchDinnerPrice => _settings.lunchDinnerPrice;
  double get fullDayPrice => _settings.fullDayPrice;

  void _loadSettings() {
    _settings = _storageService.getSettings();
    notifyListeners();
  }

  void _listenToChanges() {
    _storageService.settingsStream.listen((_) {
      _loadSettings();
    });
  }

  Future<void> toggleTheme() async {
    _settings.isDarkMode = !_settings.isDarkMode;
    await _storageService.updateSettings(_settings);
    notifyListeners();
  }

  Future<void> updatePrices({
    double? breakfast,
    double? lunchDinner,
    double? fullDay,
  }) async {
    if (breakfast != null) _settings.breakfastPrice = breakfast;
    if (lunchDinner != null) _settings.lunchDinnerPrice = lunchDinner;
    if (fullDay != null) _settings.fullDayPrice = fullDay;
    
    await _storageService.updateSettings(_settings);
    notifyListeners();
  }
}
