import 'package:flutter/material.dart' hide Badge;
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import '../../main.dart';
import '../widgets/glass_card.dart';
import 'package:intl/intl.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  List<Badge> _earnedBadges = [];
  bool _isLoading = true;

  // Master list of all possible badges
  final List<Map<String, String>> _allBadges = [
    {
      'name': 'Strategist',
      'description': 'Set a baseline for a noble green journey.',
      'iconType': 'strategy',
      'hint': 'Set your monthly budget in the Baseline Calculator.',
    },
    {
      'name': 'Solar King',
      'description': 'Master of sustainable movement.',
      'iconType': 'solar',
      'hint': 'Log 10 Transport-related actions.',
    },
    {
      'name': 'Recycle Knight',
      'description': 'Noble defender against waste.',
      'iconType': 'recycle',
      'hint': 'Log 5 Waste-related actions.',
    },
    {
      'name': 'Earth Guardian',
      'description': 'The ultimate protector of our world.',
      'iconType': 'earth',
      'hint': 'Reach Level 5 and 4,000 Eco Score.',
    },
    {
      'name': 'Budget Master',
      'description': 'Exemplary fiscal and carbon discipline.',
      'iconType': 'budget',
      'hint': 'Save over 50% of your monthly budget.',
    },
    {
      'name': 'Eco Pioneer',
      'description': 'A leader in collective green action.',
      'iconType': 'pioneer',
      'hint': 'Create your first Community Group.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchBadges();
  }

  Future<void> _fetchBadges() async {
    try {
      final badges = await client.stats.getBadges();
      if (mounted) {
        setState(() {
          _earnedBadges = badges;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  IconData _getIcon(String? type) {
    switch (type) {
      case 'solar': return Icons.wb_sunny_outlined;
      case 'recycle': return Icons.recycling;
      case 'earth': return Icons.public;
      case 'strategy': return Icons.track_changes;
      case 'pioneer': return Icons.flag_outlined;
      case 'budget': return Icons.savings_outlined;
      default: return Icons.emoji_events_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trophy Room'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: 0.05),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: _allBadges.length,
                itemBuilder: (context, index) {
                  final badgeDef = _allBadges[index];
                  final earned = _earnedBadges.firstWhereOrNull((b) => b.name == badgeDef['name']);
                  return _buildBadgeCard(badgeDef, earned);
                },
              ),
      ),
    );
  }

  Widget _buildBadgeCard(Map<String, String> definition, Badge? earned) {
    final bool isLocked = earned == null;
    final Color primaryColor = isLocked ? Colors.grey : Theme.of(context).primaryColor;
    
    return GlassCard(
      opacity: isLocked ? 0.02 : 0.05,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: isLocked ? null : [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                  child: Icon(
                    _getIcon(definition['iconType']),
                    size: 32,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  definition['name']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 14, 
                    color: isLocked ? Colors.grey : Theme.of(context).textTheme.titleLarge?.color
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isLocked ? definition['hint']! : definition['description']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10, 
                    color: isLocked ? Colors.grey.withValues(alpha: 0.7) : Theme.of(context).textTheme.bodySmall?.color,
                    fontStyle: isLocked ? FontStyle.italic : null,
                  ),
                ),
                if (!isLocked) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Earned: ${DateFormat.yMMMd().format(earned.earnedDate)}',
                    style: TextStyle(fontSize: 9, color: Theme.of(context).primaryColor.withValues(alpha: 0.7)),
                  ),
                ],
              ],
            ),
          ),
          if (isLocked)
            Positioned(
              top: 8,
              right: 8,
              child: Icon(Icons.lock_outline, size: 16, color: Colors.grey.withValues(alpha: 0.5)),
            ),
        ],
      ),
    );
  }
}

extension CollectionExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
