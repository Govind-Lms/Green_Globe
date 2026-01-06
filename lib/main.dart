import 'dart:async';
import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/core/supabase_config.dart';
import 'package:green_globe/src/presentations/views/auth/reset_password_page.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  await SupabaseConfig.initialize();
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _setupDeepLinkHandler();
  }

  void _setupDeepLinkHandler() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (AuthState data) {
        final event = data.event;
        if (event == AuthChangeEvent.passwordRecovery) {
          _scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(content: Text('Opened recovery link')),
          );
          _navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (_) => ResetPasswordPage()),
          );
        } else if (event == AuthChangeEvent.signedIn) {
          // _scaffoldMessengerKey.currentState?.showSnackBar(
          //   const SnackBar(content: Text('Signed in using deep link')),
          // );
        } else if (event == AuthChangeEvent.tokenRefreshed) {}
      },
      onError: (err) {
        debugPrint('Supabase deep link error: $err');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Globe',
      navigatorKey: _navigatorKey,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        scaffoldBackgroundColor: accentGreen,
      ),
      home: BottomNav(),
    );
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}
