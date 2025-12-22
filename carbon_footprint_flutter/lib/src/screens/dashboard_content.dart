import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import '../../main.dart'; // To access global `client`
import 'history_screen.dart';
import 'badges_screen.dart';
import '../widgets/glass_card.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  UserStats? _stats;
  List<ActionLog> _recentActions = [];
  List<ButlerEvent> _butlerEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final stats = await client.stats.getUserStats(0);
      // Insert seed check after fetching stats
      if (stats.totalCo2Saved == 0 && stats.ecoScore == 0 && stats.level == 1 && stats.streakDays == 0) {
        // If stats are all default/zero, it might mean no data, so seed it.
        // This is a simple heuristic; a more robust check might be needed.
        await client.seed.seedData();
        // Re-fetch data after seeding
        if (mounted) {
          _fetchData();
          return; // Exit to prevent further processing with old data
        }
      }
      final actions = await client.action.getActions(0);
      final suggestions = await client.butler.getActiveSuggestions();
      if (mounted) {
        setState(() {
          _stats = stats;
          _recentActions = actions;
          _butlerEvents = suggestions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching data: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final ecoScore = _stats?.ecoScore ?? 0;
    final spots = _recentActions.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.co2Saved);
    }).toList();
    
    if (spots.isEmpty) {
      spots.add(const FlSpot(0, 0));
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Eco Score Card (Premium Gradient)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: GlassCard(
                gradientColors: [
                  const Color(0xFF1B5E20),
                  const Color(0xFF43A047),
                  const Color(0xFF81C784),
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
                              const Text('Eco Score', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500)),
                              Text('$ecoScore', style: const TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.w900, letterSpacing: -2)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.eco, color: Colors.white, size: 40),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(height: 1, color: Colors.white24),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMiniStat(Icons.trending_up, 'Level', '${_stats?.level ?? 1}'),
                          _buildMiniStat(Icons.local_fire_department, 'Streak', '${_stats?.streakDays ?? 0} days'),
                          _buildMiniStat(Icons.public, 'Rank', '#4'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tip of the Day Card - Moved here for better visibility
            _buildTipCard(),
            
            const SizedBox(height: 24),

            if (_butlerEvents.isNotEmpty) ...[
              _buildButlerSuggestion(_butlerEvents.first),
              const SizedBox(height: 24),
            ],

            // Carbon Budget Gauge
            _buildBudgetGauge(),

            const SizedBox(height: 24),

            // Relatable Impact Card
            _buildImpactCard(totalCo2Saved: _stats?.totalCo2Saved ?? 0),
            
            const SizedBox(height: 24),

            Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        var res = await client.seed.seedData();
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
                        _fetchData(); 
                      } catch (e) {
                        if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    },
                    child: const Text('Admin: Seed DB'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
                    },
                    child: const Text('History'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const BadgesScreen()));
                    },
                    child: const Text('Trophies'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Forest Illustration (Absolute Path for immediate preview)
            GestureDetector(
              onTap: () => _showForestAnalysis(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                     Image.network(
                      _getForestImage(_stats?.ecoScore ?? 0),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Forest', style: TextStyle(color: Colors.white70, fontSize: 14)),
                          Text(
                            'Growing with every action.',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(Icons.touch_app, color: Colors.white54, size: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
  }

  void _showForestAnalysis() {
    final score = _stats?.ecoScore ?? 0;
    String statusTitle = "Fledgling Woods";
    String analysis = "Your journey is just beginning! With every eco-action, we shall plant more life into this landscape.";
    IconData statusIcon = Icons.park_outlined;
    double progress = (score / 1000).clamp(0.0, 1.0);
    int nextGoal = 1000;
    
    if (score >= 3000) {
      statusTitle = "Emerald Sanctuary";
      analysis = "Magnificent! Your impact has transformed this land into a lush paradise. You are a true guardian of the Earth.";
      statusIcon = Icons.auto_awesome;
      progress = 1.0;
      nextGoal = 3000;
    } else if (score >= 1000) {
      statusTitle = "Verdurous Grove";
      analysis = "The trees are taking root and the air feels fresher already. Your consistent efforts are clearly paying off.";
      statusIcon = Icons.forest;
      progress = ((score - 1000) / 2000).clamp(0.0, 1.0);
      nextGoal = 3000;
    }

    final trees = (score / 50.0).toStringAsFixed(1);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => GlassCard(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 24),
              Icon(statusIcon, color: Colors.greenAccent, size: 64),
              const SizedBox(height: 16),
              Text(statusTitle, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Rank Score: $score', style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.w500)),
              const SizedBox(height: 24),
              
              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Growth to Next Stage', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text('${(progress * 100).toInt()}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white10,
                      color: Colors.greenAccent,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Next Rank: ${nextGoal == 1000 ? "Verdurous Grove" : "Emerald Sanctuary"}', 
                      style: const TextStyle(color: Colors.white54, fontSize: 11, fontStyle: FontStyle.italic)),
                ],
              ),
              
              const SizedBox(height: 24),
              Text(
                analysis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildForestStat(Icons.park, trees, 'Trees Revived'),
                  _buildForestStat(Icons.wb_sunny, '${(score / 10).toInt()}%', 'Eco Vitality'),
                ],
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, 
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Return to Estate', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForestStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.greenAccent, size: 32),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  Widget _buildMiniStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildTipCard() {
    final tips = [
      'Washing clothes at 30°C saves up to 40% energy!',
      'Swapping one meat meal for plant-based saves 1.5kg CO2.',
      'Unplugging idle electronics can save 5% on your bill.',
      'Biking instead of driving saves 0.5kg CO2 per km.',
    ];
    final tip = tips[DateTime.now().day % tips.length];

    return GlassCard(
      opacity: 0.05,
      gradientColors: [Colors.orange.withValues(alpha: 0.1), Colors.orange.withValues(alpha: 0.05)],
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.2), shape: BoxShape.circle),
          child: const Icon(Icons.lightbulb, color: Colors.orange),
        ),
        title: const Text('Tip of the Day', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(tip),
      ),
    );
  }

  Widget _buildImpactCard({required double totalCo2Saved}) {
    final trees = (totalCo2Saved / 5.0).toStringAsFixed(1);
    
    return GlassCard(
      opacity: 0.05,
      gradientColors: [Colors.blue.withValues(alpha: 0.1), Colors.blue.withValues(alpha: 0.05)],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.park, color: Colors.green, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Relatable Impact', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Your savings are equivalent to the weekly work of $trees trees!',
                          style: TextStyle(color: Theme.of(context).hintColor)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black12),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _showBaselineCalculator(),
              icon: const Icon(Icons.calculate_outlined),
              label: const Text('Calculate my baseline footprint'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButlerSuggestion(ButlerEvent event) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: GlassCard(
        gradientColors: [
          const Color(0xFF263238),
          const Color(0xFF37474F),
        ],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.face_retouching_natural, color: Colors.blueAccent, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Text('Butler\'s Suggestion', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const Spacer(),
                  Text('${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 16),
              Text(event.message, style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.4)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () async {
                        try {
                          await client.butler.resolveEvent(event.id!);
                          if (mounted) {
                            setState(() {
                              _butlerEvents.remove(event);
                            });
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error resolving suggestion: $e')));
                          }
                        }
                      },
                      child: const Text('Maybe later', style: TextStyle(decoration: TextDecoration.underline)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        try {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Working on it!')));
                          await client.butler.sendMessage('Confirmed: ${event.message}');
                          await client.butler.resolveEvent(event.id!); // Mark as resolved persistently
                          if (mounted) {
                            setState(() {
                              _butlerEvents.remove(event);
                            });
                            _fetchData();
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                          }
                        }
                      },
                      child: const Text('Make it so'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBaselineCalculator() {
    final driveController = TextEditingController();
    final meatController = TextEditingController();
    final electricityController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Baseline Calculator', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const Text('Answer 3 quick questions to estimate your yearly footprint.'),
            const SizedBox(height: 16),
            TextField(
              controller: driveController,
              decoration: const InputDecoration(labelText: 'How many km do you drive per week?'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: meatController,
              decoration: const InputDecoration(labelText: 'How many meat meals per week?'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: electricityController,
              decoration: const InputDecoration(labelText: 'Average monthly electricity bill (\$)?'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final km = double.tryParse(driveController.text) ?? 0;
                  final meals = double.tryParse(meatController.text) ?? 0;
                  final bill = double.tryParse(electricityController.text) ?? 0;

                  // Simplified formula: 
                  // km: 0.2 kg/km * 52 weeks
                  // meals: 2.5 kg/meal * 52 weeks
                  // electricity: 0.5 kg/$ * 12 months
                  // Total yearly / 12 for monthly budget
                  double yearly = (km * 0.2 * 52) + (meals * 2.5 * 52) + (bill * 0.5 * 12);
                  double monthly = yearly / 12;

                  if (monthly < 50) monthly = 50; // Minimum floor

                  try {
                    await client.stats.updateMonthlyBudget(monthly);
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Your monthly budget has been set to ${monthly.toStringAsFixed(1)} kg CO2.'))
                      );
                      _fetchData();
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  }
                },
                child: const Text('Calculate & Save'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  String _getForestImage(int score) {
    if (score < 500) return 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?q=80&w=1948&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // Misty/Autumn
    if (score < 1500) return 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // Standard
    if (score < 3000) return 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // Lush
    if (score < 5000) return 'https://images.unsplash.com/photo-1501854140801-50d016748c5b?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // Solar/Vibrant
    return 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'; // Eco Utopia
  }

  Widget _buildBudgetGauge() {
    if (_stats == null) return const SizedBox.shrink();
    
    double used = (_stats!.monthlyBudget - _stats!.monthlyCo2Saved).clamp(0, _stats!.monthlyBudget);
    double percent = (used / _stats!.monthlyBudget).clamp(0.0, 1.0);
    
    Color gaugeColor = Colors.green;
    if (percent > 0.5) gaugeColor = Colors.orange;
    if (percent > 0.8) gaugeColor = Colors.red;

    return InkWell(
      onTap: () => _showBaselineCalculator(),
      borderRadius: BorderRadius.circular(24),
      child: GlassCard(
        child: Column(
          children: [
            const Text('Monthly Carbon Footprint', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  value: percent,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.withValues(alpha: 0.1),
                  color: gaugeColor,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${used.toStringAsFixed(1)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const Text('Remaining Footprint', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Limit: ${_stats!.monthlyBudget.toInt()}kg per month',
            style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey),
          ),
        ],
      ),
    ));
  }
}
