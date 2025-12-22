import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Ecotrajectory? _trajectory;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final actions = await client.action.getActions(0);
      final stats = await client.stats.getUserStats(0);
      final trajectory = await client.stats.getEcotrajectory();
      if (mounted) {
        setState(() {
          _allActions = actions;
          _stats = stats;
          _trajectory = trajectory;
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
          Text('Path to Net Zero', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor)),
          const Text('Long-term projection based on current habits', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          _buildTrajectoryCard(),
          const SizedBox(height: 32),
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

  Widget _buildTrajectoryCard() {
    if (_trajectory == null) return const SizedBox.shrink();
    final theme = Theme.of(context);
    
    final dateStr = "${_trajectory!.netZeroDate.day} ${_getMonthName(_trajectory!.netZeroDate.month)} ${_trajectory!.netZeroDate.year}";
    final rate = _trajectory!.savingsRate.toStringAsFixed(2);
    
    return GlassCard(
      opacity: 0.1,
      gradientColors: [
        theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
        theme.colorScheme.surface.withValues(alpha: 0.05),
      ],
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PROJECTED NET ZERO', style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text(dateStr, style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1)),
                  ],
                ),
                Icon(Icons.auto_graph_rounded, color: theme.colorScheme.primary, size: 48),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMilestone('Daily Savings', '$rate kg', Icons.bolt_rounded)),
                _buildDivider(),
                Expanded(child: _buildMilestone('Days Remaining', '${_trajectory!.daysToNetZero}', Icons.timer_outlined)),
                _buildDivider(),
                Expanded(child: _buildMilestone('Trajectory', _trajectory!.isAchievable ? 'Optimal' : 'Slowing', _trajectory!.isAchievable ? Icons.check_circle_rounded : Icons.trending_down_rounded)),
              ],
            ),
            const SizedBox(height: 24),
            Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  widthFactor: _trajectory!.isAchievable ? 0.85 : 0.45,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => Container(width: 1, height: 40, color: Colors.grey.withValues(alpha: 0.1));

  Widget _buildMilestone(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6)),
        const SizedBox(height: 8),
        Text(value, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
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
    final theme = Theme.of(context);
    final spots = _allActions.reversed.take(7).toList().asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.co2Saved);
    }).toList();

    if (spots.isEmpty) return const SizedBox(height: 100, child: Center(child: Text('No history yet.')));

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: spots.map((s) => BarChartGroupData(
            x: s.x.toInt(), 
            barRods: [
              BarChartRodData(
                toY: s.y, 
                color: theme.colorScheme.primary,
                width: 16,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.1,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                ),
              )
            ]
          )).toList(),
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
    final theme = Theme.of(context);
    final now = DateTime.now();
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    
    final sortedActions = List<ActionLog>.from(_allActions)..sort((a, b) => a.date.compareTo(b.date));
    List<FlSpot> cumulativeSpots = [];
    double runningTotal = 0;
    
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
            LineChartBarData(
              spots: cumulativeSpots,
              isCurved: true,
              color: theme.colorScheme.primary,
              barWidth: 4,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true, 
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary.withValues(alpha: 0.2), theme.colorScheme.primary.withValues(alpha: 0.01)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            LineChartBarData(
              spots: [FlSpot(1, budget), FlSpot(daysInMonth.toDouble(), budget)],
              isCurved: false,
              color: theme.colorScheme.error.withValues(alpha: 0.3),
              barWidth: 2,
              dashArray: [5, 5],
              dotData: const FlDotData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (val, _) => Text(val.toInt().toString(), style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    final theme = Theme.of(context);
    switch (category) {
      case 'Transport': return theme.colorScheme.primary;
      case 'Food': return theme.colorScheme.secondary;
      case 'Waste': return theme.colorScheme.tertiary;
      case 'Energy': return theme.colorScheme.primaryContainer;
      default: return theme.colorScheme.outlineVariant;
    }
  }

  bool _isColorLight(Color color) {
    return color.computeLuminance() > 0.5;
  }
}
