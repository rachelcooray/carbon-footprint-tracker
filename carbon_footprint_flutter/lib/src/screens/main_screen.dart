import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart'; // For sessionManager
import 'dashboard_content.dart';
import 'challenges_content.dart';
import 'social_content.dart';
import 'log_action_screen.dart';
import 'insights_screen.dart';
import 'butler_screen.dart';
import 'morning_briefing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkBriefing();
  }

  Future<void> _checkBriefing() async {
    final prefs = await SharedPreferences.getInstance();
    final lastBriefing = prefs.getString('last_briefing_date');
    final today = DateTime.now().toString().split(' ')[0];

    if (lastBriefing != today) {
      if (mounted) {
        // Show briefing overlay
        _forceBriefing();
        await prefs.setString('last_briefing_date', today);
      }
    }
  }

  void _forceBriefing() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Morning Briefing',
      pageBuilder: (context, anim1, anim2) => const MorningBriefingScreen(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      },
    );
  }

  final List<Widget> _pages = const [
    DashboardContent(),
    InsightsScreen(),
    ButlerScreen(), // New Tab
    ChallengesContent(),
    SocialContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: [
          _buildThemeToggle(),
          IconButton(
            icon: const Icon(Icons.wb_sunny_rounded),
            tooltip: 'Butler Briefing',
            onPressed: _forceBriefing,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Insights',
          ),
          NavigationDestination(
            icon: Icon(Icons.face_retouching_natural),
            selectedIcon: Icon(Icons.face_retouching_natural),
            label: 'Butler',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: 'Challenges',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Community',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1
          ? FloatingActionButton.extended(
              heroTag: 'main_fab',
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LogActionScreen()),
                );
                if (result == true) setState(() {});
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 4,
              label: Text('LOG ACTION', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1)),
              icon: const Icon(Icons.add_rounded),
            )
          : null,
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0: return 'Dashboard';
      case 1: return 'Insights';
      case 2: return 'Eco Butler';
      case 3: return 'Challenges';
      case 4: return 'Community';
      default: return 'Carbon Tracker';
    }
  }

  Widget _buildThemeToggle() {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        IconData icon;
        switch (themeMode) {
          case ThemeMode.system: icon = Icons.brightness_auto_outlined; break;
          case ThemeMode.light: icon = Icons.brightness_5_outlined; break;
          case ThemeMode.dark: icon = Icons.brightness_2_outlined; break;
        }

        return IconButton(
          icon: Icon(icon),
          tooltip: 'Toggle Theme',
          onPressed: () {
            if (themeMode == ThemeMode.system) {
              themeNotifier.value = ThemeMode.light;
            } else if (themeMode == ThemeMode.light) {
              themeNotifier.value = ThemeMode.dark;
            } else {
              themeNotifier.value = ThemeMode.system;
            }
          },
        );
      },
    );
  }
}
