import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../providers/settings_provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late int _selectedYear;
  late int _selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedYear = now.year;
    _selectedMonth = now.month;
  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    final stats = mealProvider.getMonthStatistics(
      _selectedYear,
      _selectedMonth,
      breakfastPrice: settingsProvider.breakfastPrice,
      lunchDinnerPrice: settingsProvider.lunchDinnerPrice,
      fullDayPrice: settingsProvider.fullDayPrice,
    );

    final allTimeBill = mealProvider.getCumulativeAllTimeBill(
      breakfastPrice: settingsProvider.breakfastPrice,
      lunchDinnerPrice: settingsProvider.lunchDinnerPrice,
      fullDayPrice: settingsProvider.fullDayPrice,
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMonthSelector(),
            const SizedBox(height: 24),
            _buildTotalBillCard(stats['totalBill']),
            const SizedBox(height: 24),
            _buildMealCountCard('Total Breakfasts', stats['breakfastCount'], 
                Colors.blue, Icons.breakfast_dining),
            const SizedBox(height: 12),
            _buildMealCountCard('Total Lunch + Dinner', stats['lunchDinnerCount'], 
                Colors.green, Icons.restaurant),
            const SizedBox(height: 12),
            _buildMealCountCard('Total Full Day Mess', stats['fullDayCount'], 
                Colors.orange, Icons.restaurant_menu),
            const SizedBox(height: 24),
            _buildMonthlySummaryCard(stats),
            const SizedBox(height: 24),
            _buildAllTimeBillCard(allTimeBill),
            const SizedBox(height: 16),
            _buildClearMonthButton(context, mealProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    final monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  if (_selectedMonth == 1) {
                    _selectedMonth = 12;
                    _selectedYear--;
                  } else {
                    _selectedMonth--;
                  }
                });
              },
            ),
            Text(
              '${monthNames[_selectedMonth - 1]} $_selectedYear',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  if (_selectedMonth == 12) {
                    _selectedMonth = 1;
                    _selectedYear++;
                  } else {
                    _selectedMonth++;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalBillCard(double totalBill) {
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return Card(
      elevation: 4,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Total Bill for ${monthNames[_selectedMonth - 1]}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Rs. ${totalBill.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCountCard(String title, int count, Color color, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlySummaryCard(Map<String, dynamic> stats) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Total Days Logged', stats['totalDays'].toString()),
            const SizedBox(height: 12),
            _buildSummaryRow(
              'Average Cost Per Day', 
              'Rs. ${stats['avgCostPerDay'].toStringAsFixed(2)}'
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAllTimeBillCard(double allTimeBill) {
    return Card(
      elevation: 3,
      color: Colors.deepPurple,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cumulative All-Time Bill',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Rs. ${allTimeBill.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClearMonthButton(BuildContext context, MealProvider mealProvider) {
    return OutlinedButton.icon(
      onPressed: () {
        _showClearConfirmationDialog(context, mealProvider);
      },
      icon: Icon(Icons.delete_outline, color: Colors.red),
      label: Text(
        'Clear Month Data',
        style: TextStyle(color: Colors.red),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.red),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  void _showClearConfirmationDialog(BuildContext context, MealProvider mealProvider) {
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Month Data'),
        content: Text(
          'Are you sure you want to delete all meal logs for ${monthNames[_selectedMonth - 1]} $_selectedYear? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              mealProvider.clearMonthData(_selectedYear, _selectedMonth);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Month data cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
