import 'package:flutter/material.dart';
import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import '../../main.dart'; // To access global `client`

class ChallengesContent extends StatefulWidget {
  const ChallengesContent({super.key});

  @override
  State<ChallengesContent> createState() => _ChallengesContentState();
}

class _ChallengesContentState extends State<ChallengesContent> {
  List<ChallengeProgress> _challenges = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChallenges();
  }

  Future<void> _fetchChallenges() async {
    try {
      final res = await client.challenge.getUserChallenges(0);
      if (mounted) {
        setState(() {
          _challenges = res;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_challenges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No challenges active.'),
            TextButton(onPressed: _fetchChallenges, child: const Text('Refresh'))
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _challenges.length,
      itemBuilder: (context, index) {
        final p = _challenges[index];
        final c = p.challenge;
        
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(c.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    if (p.percentComplete >= 1.0)
                      const Icon(Icons.check_circle, color: Colors.green)
                  ],
                ),
                const SizedBox(height: 4),
                Text(c.description, style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: p.percentComplete,
                  backgroundColor: Colors.grey[200],
                  color: p.percentComplete >= 1.0 ? Colors.green : Colors.blue,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${p.currentAmount.toStringAsFixed(1)} / ${c.targetAmount} ${c.unit}', 
                       style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text('${c.points} pts', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
