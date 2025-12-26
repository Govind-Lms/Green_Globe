import 'package:flutter/material.dart';
import 'package:green_globe/src/core/supabase_config.dart';
import 'package:green_globe/src/presentations/views/auth/sign_in.dart';
import 'package:green_globe/src/core/auth.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    checkSignInStatus();
  }

  Future<void> checkSignInStatus() async {
    // Check if the user is signed in
    final isSignedIn = AuthService.isSignedIn();
    setState(() {
      _isSignedIn = isSignedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Optionally show a loading indicator
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MaterialApp(
      title: 'Green Globe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF5EA560)),
      ),
      home: _isSignedIn ? const BottomNav() : const SignIn(),
    );
  }
}
