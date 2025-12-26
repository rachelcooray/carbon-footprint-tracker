import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/screens/main_screen.dart';

late final Client client;
late final SessionManager sessionManager;
final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);
final refreshNotifier = ValueNotifier<int>(0); // Global Refresh Signal

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final rawServerUrl =
      serverUrlFromEnv.isEmpty ? 'https://carbon-server.onrender.com' : serverUrlFromEnv; //
  final serverUrl = rawServerUrl.endsWith('/') ? rawServerUrl : '$rawServerUrl/';

  client = Client(
    serverUrl,
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // Initialize Session Manager
  sessionManager = SessionManager(
    caller: client.modules.auth,
  );
  
  try {
    await sessionManager.initialize().timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint('Session initialization failed: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Rebuild the app whenever the sign-in status changes
    sessionManager.addListener(_onSessionChange);
  }

  @override
  void dispose() {
    sessionManager.removeListener(_onSessionChange);
    super.dispose();
  }

  void _onSessionChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Carbon Footprint',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1B5E20), // Deep Forest Green
              primary: const Color(0xFF2E7D32),
              secondary: const Color(0xFF388E3C), // Stronger green
              tertiary: const Color(0xFFFBC02D), // Gold for accents
              surface: Colors.white,
              brightness: Brightness.light,
            ),
            textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
              headlineMedium: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
              titleLarge: const TextStyle(fontWeight: FontWeight.w600),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: GoogleFonts.outfit(color: const Color(0xFF1B5E20), fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: const IconThemeData(color: Color(0xFF1B5E20)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF81C784),
              primary: const Color(0xFF43A047),
              secondary: const Color(0xFFA5D6A7),
              tertiary: const Color(0xFFFFD54F),
              surface: const Color(0xFF0A0A0A), // Deeper dark
              brightness: Brightness.dark,
            ),
            textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
              headlineMedium: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
              titleLarge: const TextStyle(fontWeight: FontWeight.w600),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                textStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          themeMode: themeMode,
          home: _homePage(),
        );
      }
    );
  }

  Widget _homePage() {
    if (sessionManager.isSignedIn) {
      return const MainScreen();
    } else {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco_rounded, size: 80, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontSize: 32, // Larger for landing page
                      color: Theme.of(context).colorScheme.primary, // Consistent green
                    ),
                    children: [
                      const TextSpan(text: 'Carbon '),
                      TextSpan(
                        text: 'Footprint', 
                        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                     Navigator.of(context).push(
                       MaterialPageRoute(builder: (context) => SignInScreen(caller: client.modules.auth)),
                     );
                  },
                  icon: const Icon(Icons.email_rounded),
                  label: const Text('Sign in with Email'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
