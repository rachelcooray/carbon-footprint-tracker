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
  List<Badge> _badges = [];
  bool _isLoading = true;

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
          _badges = badges;
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
            : _badges.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _badges.length,
                    itemBuilder: (context, index) {
                      final badge = _badges[index];
                      return _buildBadgeCard(badge);
                    },
                  ),
      ),
    );
  }

  Widget _buildBadgeCard(Badge badge) {
    return GlassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]
            ),
            child: Icon(
              _getIcon(badge.iconType),
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            badge.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            badge.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Earned: ${DateFormat.yMMMd().format(badge.earnedDate)}',
            style: const TextStyle(fontSize: 10, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 80, color: Colors.grey.withValues(alpha: 0.3)),
          const SizedBox(height: 24),
          const Text('Your Trophy Room is empty, sir.', style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Perform eco-actions to earn your first honor.', style: TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
