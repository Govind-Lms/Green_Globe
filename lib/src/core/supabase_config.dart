import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase configuration and initialization
class SupabaseConfig {
  // You can find these in your Supabase project settings
  static const String supabaseUrl = 'https://jamxdtkeobfqjzsmidtd.supabase.co';
  static const String supabaseAnonKey =
      'sb_publishable_cRc6AkTKjyQonlXpmbkyLw_oNe3PrJf';
  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImphbXhkdGtlb2JmcWp6c21pZHRkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYyNDYxOTIsImV4cCI6MjA4MTgyMjE5Mn0.ihkKfMfg6SUPzKTBGpIlFhkQV2WvstNQwwko_hcVwcw'

  /// Initialize Supabase
  ///
  /// Call this in main() before runApp()
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: false,
    );
  }
}
