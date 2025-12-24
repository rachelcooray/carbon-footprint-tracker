import 'package:flutter/material.dart';
import '../../main.dart';
import '../widgets/glass_card.dart';

class MorningBriefingScreen extends StatefulWidget {
  const MorningBriefingScreen({super.key});

  @override
  State<MorningBriefingScreen> createState() => _MorningBriefingScreenState();
}

class _MorningBriefingScreenState extends State<MorningBriefingScreen> with SingleTickerProviderStateMixin {
  String _briefingText = "Preparing your environmental dossier...";
  bool _isLoading = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  String _getTimeContext() {
    final now = DateTime.now();
    if (now.hour >= 5 && now.hour < 12) return "morning";
    if (now.hour >= 12 && now.hour < 17) return "afternoon";
    if (now.hour >= 17 && now.hour < 21) return "evening";
    return "night";
  }

  IconData _getTimeIcon() {
    final now = DateTime.now();
    if (now.hour >= 5 && now.hour < 17) return Icons.wb_sunny_outlined;
    if (now.hour >= 17 && now.hour < 21) return Icons.wb_twilight_outlined;
    return Icons.nightlight_round_outlined;
  }

  Color _getTimeIconColor() {
    final now = DateTime.now();
    if (now.hour >= 5 && now.hour < 17) return Colors.orange;
    if (now.hour >= 17 && now.hour < 21) return Colors.deepOrangeAccent;
    return Colors.blueAccent;
  }

  @override
  void initState() {
    super.initState();
    final userName = sessionManager.signedInUser?.userName ?? "Friend";
    final context = _getTimeContext();
    _briefingText = "Good $context, $userName! I am preparing your environmental dossier for the $context...";
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _fetchBriefing();
  }

  Future<void> _fetchBriefing() async {
    try {
      final text = await client.butler.generateDailyBriefing();
      if (mounted) {
        setState(() {
          _briefingText = text;
          _isLoading = false;
        });
        _controller.forward();
      }
    } catch (e) {
      if (mounted) {
        final userName = sessionManager.signedInUser?.userName ?? "Friend";
        final context = _getTimeContext();
        setState(() {
          _briefingText = "Good $context, $userName. Let us embark on another $context of noble environmental preservation.";
          _isLoading = false;
        });
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeContext = _getTimeContext();
    final capitalizedContext = timeContext[0].toUpperCase() + timeContext.substring(1);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Frosted background
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.8),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: GlassCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_getTimeIcon(), size: 48, color: _getTimeIconColor()),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '$capitalizedContext Briefing',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Force white for visibility on dark overlay
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_isLoading)
                        const CircularProgressIndicator(color: Colors.white70)
                      else
                        Text(
                          _briefingText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16, 
                            height: 1.6, 
                            fontStyle: FontStyle.italic,
                            color: Colors.white70, // Consistent light grey/white
                          ),
                        ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text('As you wish, Butler'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
