import 'package:flutter/material.dart';
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
        showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierLabel: 'Morning Briefing',
          pageBuilder: (context, anim1, anim2) => const MorningBriefingScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionBuilder: (context, anim1, anim2, child) {
            return FadeTransition(opacity: anim1, child: child);
          },
        );
        await prefs.setString('last_briefing_date', today);
      }
    }
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
          if (_currentIndex == 0 || _currentIndex == 1 || _currentIndex == 3 || _currentIndex == 4)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () => setState(() {}), // Triggers initState/build in sub-pages
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => sessionManager.signOutDevice(),
          ),
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
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1 // Only on Home/Insights
          ? FloatingActionButton.extended(
              heroTag: 'main_fab',
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LogActionScreen()),
                );
                if (result == true) {
                   setState(() {});
                }
              },
              label: const Text('Log Action'),
              icon: const Icon(Icons.add),
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
