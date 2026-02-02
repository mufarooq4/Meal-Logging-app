import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class HapticService {
  static final HapticService _instance = HapticService._internal();
  factory HapticService() => _instance;
  HapticService._internal();

  bool _hasVibrator = false;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      final hasVibrator = await Vibration.hasVibrator();
      _hasVibrator = hasVibrator == true;
      _initialized = true;
    } catch (e) {
      _hasVibrator = false;
      _initialized = true;
    }
  }

  // Light tap feedback (for buttons, toggles)
  Future<void> light() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      // Fallback for platforms that don't support haptics
    }
  }

  // Medium tap feedback (for selections)
  Future<void> medium() async {
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      // Fallback
    }
  }

  // Heavy feedback (for important actions)
  Future<void> heavy() async {
    try {
      await HapticFeedback.heavyImpact();
    } catch (e) {
      // Fallback
    }
  }

  // Selection feedback (for scrolling through options)
  Future<void> selection() async {
    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      // Fallback
    }
  }

  // Success pattern (for completed actions)
  Future<void> success() async {
    if (_hasVibrator) {
      try {
        await Vibration.vibrate(duration: 50);
        await Future.delayed(const Duration(milliseconds: 100));
        await Vibration.vibrate(duration: 50);
      } catch (e) {
        await heavy();
      }
    } else {
      await heavy();
    }
  }

  // Error pattern (for failures)
  Future<void> error() async {
    if (_hasVibrator) {
      try {
        await Vibration.vibrate(duration: 200);
      } catch (e) {
        await heavy();
      }
    } else {
      await heavy();
    }
  }

  // Warning pattern (for alerts)
  Future<void> warning() async {
    if (_hasVibrator) {
      try {
        await Vibration.vibrate(duration: 100);
        await Future.delayed(const Duration(milliseconds: 50));
        await Vibration.vibrate(duration: 100);
        await Future.delayed(const Duration(milliseconds: 50));
        await Vibration.vibrate(duration: 100);
      } catch (e) {
        await medium();
      }
    } else {
      await medium();
    }
  }
}
