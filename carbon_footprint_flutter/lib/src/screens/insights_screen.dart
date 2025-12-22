import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import '../../main.dart';
import '../widgets/glass_card.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  bool _isLoading = true;
  List<ActionLog> _allActions = [];
  UserStats? _stats;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final actions = await client.action.getActions(0);
      final stats = await client.stats.getUserStats(0);
      if (mounted) {
        setState(() {
          _allActions = actions;
          _stats = stats;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Savings Breakdown', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor)),
          const Text('Where your impact is felt most', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          GlassCard(
            opacity: 0.05,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildCategoryChart(),
            ),
          ),
          const SizedBox(height: 32),
          Text('Historical Progress', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor)),
          const Text('Your journey over time', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          GlassCard(
            opacity: 0.05,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildTrendChart(),
            ),
          ),
          const SizedBox(height: 32),
          Text('Goal Tracking', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor)),
          const Text('Cumulative savings vs Monthly Budget', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          GlassCard(
            opacity: 0.05,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildCumulativeChart(),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCategoryChart() {
    Map<String, double> categories = {};
    for (var log in _allActions) {
      final cat = log.action?.category ?? 'Other';
      categories[cat] = (categories[cat] ?? 0) + log.co2Saved;
    }

    if (categories.isEmpty) return const Center(child: Text('Log more actions to see breakdowns!'));

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: categories.entries.map((e) {
            return PieChartSectionData(
              value: e.value,
              title: e.key,
              color: _getColorForCategory(e.key),
              radius: 50,
              titleStyle: TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.bold, 
                color: _isColorLight(_getColorForCategory(e.key)) ? Colors.black87 : Colors.white
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTrendChart() {
    // Simplified: Show last 7 entries
    final spots = _allActions.reversed.take(7).toList().asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.co2Saved);
    }).toList();

    if (spots.isEmpty) return const SizedBox(height: 100, child: Center(child: Text('No history yet.')));

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: spots.map((s) => BarChartGroupData(x: s.x.toInt(), barRods: [BarChartRodData(toY: s.y, color: Colors.green)])).toList(),
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget _buildCumulativeChart() {
    if (_stats == null || _allActions.isEmpty) return const SizedBox(height: 100, child: Center(child: Text('Not enough data to track goals.')));

    final now = DateTime.now();
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    
    // Sort actions by date
    final sortedActions = List<ActionLog>.from(_allActions)..sort((a, b) => a.date.compareTo(b.date));
    
    List<FlSpot> cumulativeSpots = [];
    double runningTotal = 0;
    
    // Simple logic: Group actions by day of current month
    Map<int, double> dailySavings = {};
    for (var log in sortedActions) {
      if (log.date.month == now.month && log.date.year == now.year) {
        dailySavings[log.date.day] = (dailySavings[log.date.day] ?? 0) + log.co2Saved;
      }
    }

    for (int day = 1; day <= now.day; day++) {
      runningTotal += dailySavings[day] ?? 0;
      cumulativeSpots.add(FlSpot(day.toDouble(), runningTotal));
    }

    final budget = _stats!.monthlyBudget;

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: daysInMonth.toDouble(),
          minY: 0,
          maxY: (runningTotal > budget ? runningTotal : budget) * 1.2,
          lineBarsData: [
            // Cumulative Savings Line
            LineChartBarData(
              spots: cumulativeSpots,
              isCurved: true,
              color: Colors.green,
              barWidth: 4,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: true, color: Colors.green.withValues(alpha: 0.1)),
            ),
            // Budget Target Line (Static)
            LineChartBarData(
              spots: [FlSpot(1, budget), FlSpot(daysInMonth.toDouble(), budget)],
              isCurved: false,
              color: Colors.red.withValues(alpha: 0.3),
              barWidth: 2,
              dashArray: [5, 5],
              dotData: const FlDotData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (val, _) => Text(val.toInt().toString(), style: const TextStyle(fontSize: 10)),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Transport': return const Color(0xFF2E7D32);
      case 'Food': return const Color(0xFF81C784);
      case 'Waste': return const Color(0xFF1B5E20);
      case 'Energy': return const Color(0xFFC8E6C9);
      default: return Colors.blueGrey.shade200;
    }
  }

  bool _isColorLight(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.light;
  }
}
