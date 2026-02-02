import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/meal_log.dart';
import '../models/date_alarm.dart';
import '../providers/meal_provider.dart';
import '../providers/alarm_provider.dart';
import '../services/haptic_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final HapticService _haptics = HapticService();

  @override
  void initState() {
    super.initState();
    _haptics.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCalendar(),
                  const SizedBox(height: 12),
                  _buildLegendCard(),
                  const SizedBox(height: 16),
                  _buildFooter(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Developed for GIKI with ❤️',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.color
                  ?.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'by mufarooq9000@gmail.com',
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final mealProvider = Provider.of<MealProvider>(context);
    final alarmProvider = Provider.of<AlarmProvider>(context);

    return TableCalendar(
      firstDay: DateTime(2020, 1, 1),
      lastDay: DateTime(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        _haptics.light();
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        _showMealSelectionSheet(context, selectedDay);
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return _buildOptimizedCalendarCell(
            day,
            mealProvider.getMealForDate(day),
            alarmProvider.getAlarmForDate(day),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return _buildOptimizedCalendarCell(
            day,
            mealProvider.getMealForDate(day),
            alarmProvider.getAlarmForDate(day),
            isToday: true,
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return _buildOptimizedCalendarCell(
            day,
            mealProvider.getMealForDate(day),
            alarmProvider.getAlarmForDate(day),
            isSelected: true,
          );
        },
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Optimized cell builder with const where possible
  Widget _buildOptimizedCalendarCell(
    DateTime day,
    MealLog? mealLog,
    DateAlarm? alarm, {
    bool isToday = false,
    bool isSelected = false,
  }) {
    Color? backgroundColor;

    if (mealLog != null) {
      switch (mealLog.mealType) {
        case MealType.breakfast:
          backgroundColor = Colors.blue.withOpacity(0.7);
          break;
        case MealType.lunchDinner:
          backgroundColor = Colors.green.withOpacity(0.7);
          break;
        case MealType.fullDay:
          backgroundColor = Colors.orange.withOpacity(0.7);
          break;
      }
    }

    final hasAlarm = alarm != null;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isToday ? Theme.of(context).primaryColor.withOpacity(0.3) : null),
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: Theme.of(context).primaryColor, width: 2)
            : null,
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: mealLog != null ? Colors.white : null,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (hasAlarm)
            Positioned(
              top: 2,
              right: 2,
              child: Icon(
                Icons.alarm,
                size: 12,
                color: mealLog != null ? Colors.white : Colors.red,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLegendCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Legend:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _LegendItem(color: Colors.blue, label: 'Breakfast'),
            SizedBox(height: 8),
            _LegendItem(color: Colors.green, label: 'Lunch + Dinner'),
            SizedBox(height: 8),
            _LegendItem(color: Colors.orange, label: 'Full Day Mess'),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.alarm, size: 20, color: Colors.red),
                SizedBox(width: 12),
                Text('Alarm Set', style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMealSelectionSheet(BuildContext context, DateTime selectedDay) {
    final mealProvider = Provider.of<MealProvider>(context, listen: false);
    final alarmProvider = Provider.of<AlarmProvider>(context, listen: false);
    final existingLog = mealProvider.getMealForDate(selectedDay);
    final existingAlarm = alarmProvider.getAlarmForDate(selectedDay);

    _haptics.medium();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Log Meal for ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildMealOption(
              context,
              'Breakfast',
              Icons.breakfast_dining,
              Colors.blue,
              MealType.breakfast,
              selectedDay,
            ),
            const SizedBox(height: 12),
            _buildMealOption(
              context,
              'Lunch + Dinner',
              Icons.restaurant,
              Colors.green,
              MealType.lunchDinner,
              selectedDay,
            ),
            const SizedBox(height: 12),
            _buildMealOption(
              context,
              'Full Day Mess',
              Icons.restaurant_menu,
              Colors.orange,
              MealType.fullDay,
              selectedDay,
            ),
            if (existingLog != null) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  _haptics.warning();
                  mealProvider.deleteMeal(selectedDay);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('Remove Log',
                    style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
            const Divider(height: 32),
            // Alarm Section
            Row(
              children: [
                const Icon(Icons.alarm, color: Colors.orange),
                const SizedBox(width: 8),
                const Text(
                  'Set Reminder',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (existingAlarm != null) ...[
              Card(
                color: Colors.orange.shade50,
                child: ListTile(
                  leading: const Icon(Icons.alarm_on, color: Colors.orange),
                  title: Text('Alarm set for ${existingAlarm.timeString}'),
                  subtitle: Text(existingAlarm.message),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _haptics.light();
                          _showAlarmTimePicker(
                              context, selectedDay, existingAlarm);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          _haptics.warning();
                          await alarmProvider.deleteAlarm(selectedDay);
                          if (context.mounted) Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              ElevatedButton.icon(
                onPressed: () {
                  _haptics.light();
                  _showAlarmTimePicker(context, selectedDay, null);
                },
                icon: const Icon(Icons.alarm_add),
                label: const Text('Set Alarm for This Day'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildMealOption(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    MealType mealType,
    DateTime selectedDay,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        _haptics.success();
        final mealProvider = Provider.of<MealProvider>(context, listen: false);
        mealProvider.logMeal(selectedDay, mealType);
        Navigator.pop(context);
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _showAlarmTimePicker(
    BuildContext context,
    DateTime date,
    DateAlarm? existingAlarm,
  ) async {
    final currentTime = existingAlarm != null
        ? TimeOfDay(hour: existingAlarm.hour, minute: existingAlarm.minute)
        : const TimeOfDay(hour: 14, minute: 0);

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Theme.of(context).cardColor,
              hourMinuteTextColor: Theme.of(context).primaryColor,
              dialHandColor: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && context.mounted) {
      _haptics.success();
      final alarmProvider = Provider.of<AlarmProvider>(context, listen: false);

      await alarmProvider.setAlarm(
        date,
        pickedTime.hour,
        pickedTime.minute,
        'Mess Out Time! Don\'t forget to log your meal for ${date.day}/${date.month}.',
      );

      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Alarm set for ${date.day}/${date.month} at ${pickedTime.format(context)}',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _haptics.light();
                    alarmProvider.testAlarm(
                      'Test alarm for ${date.day}/${date.month}',
                    );
                  },
                  child: const Text(
                    'TEST',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }
}

// Const widget for better performance
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
