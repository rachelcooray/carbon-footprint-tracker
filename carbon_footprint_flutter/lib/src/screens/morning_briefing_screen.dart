import 'package:flutter/material.dart';
import '../../main.dart';
import '../widgets/glass_card.dart';

class MorningBriefingScreen extends StatefulWidget {
  const MorningBriefingScreen({super.key});

  @override
  State<MorningBriefingScreen> createState() => _MorningBriefingScreenState();
}

class _MorningBriefingScreenState extends State<MorningBriefingScreen> with SingleTickerProviderStateMixin {
  String _briefingText = "Good morning! I am preparing your environmental dossier for the day...";
  bool _isLoading = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
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
        setState(() {
          _briefingText = "Good morning, sir/madam. Let us embark on another day of noble environmental preservation.";
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
                        child: const Icon(Icons.wb_sunny_outlined, size: 48, color: Colors.orange),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Morning Briefing',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else
                        Text(
                          _briefingText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16, height: 1.6, fontStyle: FontStyle.italic),
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
