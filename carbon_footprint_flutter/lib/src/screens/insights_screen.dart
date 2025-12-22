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

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final actions = await client.action.getActions(0);
      if (mounted) {
        setState(() {
          _allActions = actions;
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
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
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

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Transport': return const Color(0xFF2E7D32);
      case 'Food': return const Color(0xFF81C784);
      case 'Waste': return const Color(0xFF1B5E20);
      case 'Energy': return const Color(0xFFC8E6C9);
      default: return Colors.blueGrey.shade200;
    }
  }
}
