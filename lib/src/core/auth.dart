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

        try {
          // Insert into users table
          await _client.from('users').insert({
            'user_id': userId,
            'email': userEmail,
            'profile_picture_url': randomProfilePictureUrl,
            'points': 0,
            'points_history': [],
          });
        } on PostgrestException catch (e) {
          // Clean up the user on Supabase Auth if user record insertion failed
          await _client.auth.admin.deleteUser(userId);
          throw Exception('Failed to create user record: ${e.message}');
        }
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

  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final session = _client.auth.currentSession;
      if (session == null) {
        throw AuthException('User is not signed in.');
      }
      final email = session.user.email;
      if (email == null || email.isEmpty) {
        throw AuthException('Failed to retrieve current email address.');
      }

      // Attempt sign-in for password validation (will throw on error)
      await _client.auth.signInWithPassword(
        email: email,
        password: oldPassword,
      );

      // Change the password
      await _client.auth.updateUser(UserAttributes(password: newPassword));
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception(
        'An unexpected error occurred while changing password: $e',
      );
    }
  }

  static Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception('An unexpected error occurred during sign out: $e');
    }
  }

  
  static Future<void> deleteAccount({String? password}) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw AuthException('User is not signed in.');
      }

      // Re-authenticate user by signing in again if password is provided.
      if (password != null && user.email != null) {
        await _client.auth.signInWithPassword(
          email: user.email!,
          password: password,
        );
      }

      
      await _client.auth.admin.deleteUser(user.id);
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception(
        'An unexpected error occurred while deleting account: $e',
      );
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
