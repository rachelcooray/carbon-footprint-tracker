import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart'; // For sessionManager
import 'dashboard_content.dart';
import '../widgets/responsive_center.dart';
import 'challenges_content.dart';
import 'social_content.dart';
import 'log_action_screen.dart';
import 'insights_screen.dart';
import 'butler_screen.dart';
import 'morning_briefing_screen.dart';
import 'settings_screen.dart';
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
    refreshNotifier.addListener(_onGlobalRefresh); // Listen for refresh
  }

  @override
  void dispose() {
    refreshNotifier.removeListener(_onGlobalRefresh);
    super.dispose();
  }

  void _onGlobalRefresh() {
    setState(() {
      // Re-initialize pages to force full refresh
      // This is a "hard" refresh of the widget tree for tabs
      _key = UniqueKey(); 
    });
  }

  // Key to force rebuild of the body
  Key _key = UniqueKey();

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
        title: Row(
          children: [
            Icon(Icons.eco_rounded, color: Theme.of(context).colorScheme.primary, size: 28),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 22,
                ),
                children: [
                  const TextSpan(text: 'Carbon '),
                  TextSpan(
                    text: 'Footprint', 
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          _buildThemeToggle(),
          IconButton(
            icon: const Icon(Icons.wb_sunny_rounded),
            tooltip: 'Butler Briefing',
            onPressed: _forceBriefing,
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ResponsiveCenter(
        child: IndexedStack(
          key: _key,
          index: _currentIndex,
          children: _pages,
        ),
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
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              elevation: 4,
              label: Text('LOG ACTION', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1)),
              icon: const Icon(Icons.add_rounded),
            )
          : null,
    );
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
