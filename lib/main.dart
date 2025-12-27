import 'package:flutter/material.dart';
import 'package:green_globe/src/const/constant.dart';
import 'package:green_globe/src/core/supabase_config.dart';
import 'package:green_globe/src/presentations/views/bottom_nav/nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Globe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen),
      ),
      home: BottomNav(),
    );
  }
}
