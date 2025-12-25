import 'dart:math';
import 'package:green_globe/src/const/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Authentication service for handling user sign in, sign out, and password reset
class AuthService {
  static SupabaseClient get _client => Supabase.instance.client;

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
    String? emailRedirectTo,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: data,
        emailRedirectTo: emailRedirectTo,
      );

      if (response.user != null) {
        final userId = response.user!.id;
        final userEmail = email.trim();

        // Get random profile picture URL
        final random = Random();
        final randomProfilePictureUrl =
            profilePictureUrls[random.nextInt(profilePictureUrls.length)];

        // Insert into users table
        await _client.from('users').insert({
          'user_id': userId,
          'email': userEmail,
          'profile_picture_url': randomProfilePictureUrl,
          'points': 0,
          'points_history': [],
        });
      }

      return response;
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } on PostgrestException catch (e) {
      // Handle database insertion errors
      throw Exception('Failed to create user record: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// Sign out the current user
  ///
  /// Returns void on success
  /// Throws [AuthException] if sign out fails
  static Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception('An unexpected error occurred during sign out: $e');
    }
  }

  static Future<void> forgotPassword({
    required String email,
    String? redirectTo,
  }) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: redirectTo,
      );
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  static Session? getCurrentSession() {
    return _client.auth.currentSession;
  }

  static User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  static bool isSignedIn() {
    return _client.auth.currentUser != null;
  }

  static Stream<AuthState> get authStateChanges =>
      _client.auth.onAuthStateChange;
}
