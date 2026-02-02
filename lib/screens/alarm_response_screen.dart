import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alarm_provider.dart';
import '../services/haptic_service.dart';

class AlarmResponseScreen extends StatefulWidget {
  final DateTime alarmDate;
  final String originalMessage;
  final String actionId;

  const AlarmResponseScreen({
    Key? key,
    required this.alarmDate,
    required this.originalMessage,
    required this.actionId,
  }) : super(key: key);

  @override
  State<AlarmResponseScreen> createState() => _AlarmResponseScreenState();
}

class _AlarmResponseScreenState extends State<AlarmResponseScreen> {
  TimeOfDay? _selectedTime;
  final HapticService _haptics = HapticService();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _haptics.initialize();
    _messageController.text = widget.originalMessage;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    await _haptics.selection();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
      await _haptics.success();
    }
  }

  Future<void> _setReminder() async {
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time first!'),
          backgroundColor: Colors.orange,
        ),
      );
      await _haptics.warning();
      return;
    }

    final alarmProvider = context.read<AlarmProvider>();
    
    await alarmProvider.setAlarm(
      widget.alarmDate,
      _selectedTime!.hour,
      _selectedTime!.minute,
      _messageController.text,
    );

    await _haptics.success();

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reminder set for ${_selectedTime!.format(context)}',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isConfirmedOut = widget.actionId == 'confirmed_out';
    final bool isRemindLater = widget.actionId == 'remind_later';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isConfirmedOut ? '✅ Confirmed Out' : '⏰ Set Reminder',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icon
            Icon(
              isConfirmedOut ? Icons.check_circle : Icons.alarm,
              size: 80,
              color: isConfirmedOut ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              isConfirmedOut
                  ? 'Great! You\'re out of mess'
                  : 'When should we remind you?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Message
            Text(
              isConfirmedOut
                  ? 'Your mess out status has been confirmed for today.'
                  : 'Set a new time for the reminder, or dismiss if you don\'t need one.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Actions based on button pressed
            if (isConfirmedOut) ...[
              ElevatedButton(
                onPressed: () async {
                  await _haptics.success();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ] else if (isRemindLater) ...[
              // Time picker card
              Card(
                elevation: 2,
                child: InkWell(
                  onTap: _pickTime,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _selectedTime == null
                                  ? 'Select Time'
                                  : _selectedTime!.format(context),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Message field
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Reminder Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.message),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // Set Reminder Button
              ElevatedButton(
                onPressed: _setReminder,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Set Reminder',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),

              // Dismiss Button
              OutlinedButton(
                onPressed: () async {
                  await _haptics.light();
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Not Now',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
