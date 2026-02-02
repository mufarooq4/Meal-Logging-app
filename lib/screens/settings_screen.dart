import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _breakfastController;
  late TextEditingController _lunchDinnerController;
  late TextEditingController _fullDayController;

  @override
  void initState() {
    super.initState();
    _breakfastController = TextEditingController();
    _lunchDinnerController = TextEditingController();
    _fullDayController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final settingsProvider = Provider.of<SettingsProvider>(context);
    _breakfastController.text = settingsProvider.breakfastPrice.toStringAsFixed(2);
    _lunchDinnerController.text = settingsProvider.lunchDinnerPrice.toStringAsFixed(2);
    _fullDayController.text = settingsProvider.fullDayPrice.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _breakfastController.dispose();
    _lunchDinnerController.dispose();
    _fullDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Configuration',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Set the prices for different meal types',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildPriceField(
              'Breakfast Price',
              _breakfastController,
              Icons.breakfast_dining,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildPriceField(
              'Lunch + Dinner Price',
              _lunchDinnerController,
              Icons.restaurant,
              Colors.green,
            ),
            const SizedBox(height: 16),
            _buildPriceField(
              'Full Day Mess Price',
              _fullDayController,
              Icons.restaurant_menu,
              Colors.orange,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                _savePrices(context, settingsProvider);
              },
              icon: Icon(Icons.save),
              label: Text('Save Prices'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceField(
    String label,
    TextEditingController controller,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.5), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      prefixText: 'Rs. ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      isDense: true,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 1,
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'These prices will be used to calculate your monthly and all-time meal expenses.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _savePrices(BuildContext context, SettingsProvider settingsProvider) {
    try {
      final breakfast = double.parse(_breakfastController.text);
      final lunchDinner = double.parse(_lunchDinnerController.text);
      final fullDay = double.parse(_fullDayController.text);

      if (breakfast < 0 || lunchDinner < 0 || fullDay < 0) {
        _showErrorSnackBar('Prices cannot be negative');
        return;
      }

      settingsProvider.updatePrices(
        breakfast: breakfast,
        lunchDinner: lunchDinner,
        fullDay: fullDay,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Prices saved successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      _showErrorSnackBar('Please enter valid numbers');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
