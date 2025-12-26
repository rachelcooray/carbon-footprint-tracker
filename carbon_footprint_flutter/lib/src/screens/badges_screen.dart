import 'package:flutter/material.dart' hide Badge;
import 'package:google_fonts/google_fonts.dart';
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, // Cards will be at most 200px wide
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8, // Slightly taller for better reading
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
    final theme = Theme.of(context);
    final bool isLocked = earned == null;
    final Color primaryColor = isLocked ? Colors.grey : theme.colorScheme.primary;
    final Color glowColor = isLocked ? Colors.transparent : theme.colorScheme.tertiary;

    return GlassCard(
      opacity: isLocked ? 0.02 : 0.08,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                        color: glowColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                  child: Icon(
                    _getIcon(definition['iconType']),
                    size: 36,
                    color: isLocked ? Colors.grey : theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  definition['name']!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold, 
                    fontSize: 15, 
                    color: isLocked ? Colors.grey : theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isLocked ? definition['hint']! : definition['description']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11, 
                    color: isLocked ? Colors.grey.withValues(alpha: 0.6) : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    fontStyle: isLocked ? FontStyle.italic : null,
                  ),
                ),
                if (!isLocked) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'EARNED',
                      style: GoogleFonts.outfit(fontSize: 8, fontWeight: FontWeight.bold, color: theme.colorScheme.primary, letterSpacing: 1),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isLocked)
            Positioned(
              top: 12,
              right: 12,
              child: Icon(Icons.lock_rounded, size: 14, color: Colors.grey.withValues(alpha: 0.4)),
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
