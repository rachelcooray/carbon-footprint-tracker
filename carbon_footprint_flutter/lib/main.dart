import 'package:carbon_footprint_client/carbon_footprint_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'src/screens/main_screen.dart';

late final Client client;
late final SessionManager sessionManager;
final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final serverUrl =
      serverUrlFromEnv.isEmpty ? 'http://localhost:8080/' : serverUrlFromEnv;

  client = Client(
    serverUrl,
     authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();

  // Initialize Session Manager
  sessionManager = SessionManager(
    caller: client.modules.auth,
  );
  await sessionManager.initialize();

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
          title: 'Carbon Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1B5E20), // Deep Forest Green
              primary: const Color(0xFF2E7D32),
              secondary: const Color(0xFF81C784), // Soft Sage
              surface: Colors.white,
              brightness: Brightness.light,
            ),
            textTheme: const TextTheme(
              headlineMedium: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
              titleLarge: TextStyle(fontWeight: FontWeight.w600),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(color: Color(0xFF1B5E20), fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Color(0xFF1B5E20)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF81C784),
              primary: const Color(0xFF43A047),
              secondary: const Color(0xFFA5D6A7),
              surface: const Color(0xFF121212),
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                const Icon(Icons.eco, size: 80, color: Colors.green),
                const SizedBox(height: 16),
                Text(
                  'Carbon Tracker',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 32),
                SignInWithEmailButton(
                  caller: client.modules.auth,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
