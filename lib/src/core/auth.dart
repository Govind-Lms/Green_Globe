import 'dart:math';
import 'package:green_globe/src/const/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// Authentication service for handling user sign in, sign out, and password reset
class AuthService {
  static SupabaseClient get _client => Supabase.instance.client;

  static Future getUsers(String email) async {
    try {
      final session = _client.auth.currentSession;
      final currentEmail = session?.user.email;

      if (currentEmail == null) {
        throw AuthException('Not signed in or email claim missing in JWT.');
      }

      final res = await _client
          .from('users')
          .select()
          .eq('email', currentEmail)
          .maybeSingle();
      return res;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

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
  }) async {
    try {
      final redirect = 'greenglobe://auth';

      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: data,
        emailRedirectTo: redirect,
      );

      if (response.user != null) {
        final userId = response.user?.id;
        final userEmail = email.trim();

        // Get random profile picture URL
        final random = Random();
        final randomProfilePictureUrl =
            profilePictureUrls[random.nextInt(profilePictureUrls.length)];

        try {
          await _client.from('users').insert({
            'user_id': userId ?? Uuid().v4().toLowerCase(),
            'email': userEmail,
            'profile_picture_url': randomProfilePictureUrl,
            'points': 0,
            'points_history': [],
          });

          try {
            await _client.auth.resend(
              type: OtpType.email,
              email: userEmail,
              emailRedirectTo: redirect,
            );
          } catch (_) {}
        } on PostgrestException catch (e) {
          await _client.auth.admin.deleteUser(userId!);
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

  static Future<void> deleteAccountViaEdgeFunction(String? password) async {
    try {
      final session = _client.auth.currentSession;
      if (session == null) {
        throw AuthException('User is not signed in.');
      }
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

      final accessToken = session.accessToken;
      if (accessToken.isEmpty) {
        throw AuthException('No access token available for current session.');
      }

      try {
        await _client.functions.invoke('del', body: {"user_id": user.id});
        await _client.from("users").delete().eq("email", user.email!);
        await _client
            .from("reports_admin")
            .delete()
            .eq("reporter", user.email!);
        await signOut();
      } catch (e) {
        // print(e.toString());
        throw e.toString();
      }
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception(
        'An unexpected error occurred while deleting account: $e',
      );
    }
  }

  static Future<void> forgotPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'greenglobe://auth',
      );
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  static Future<void> updatePassword({required String password}) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: password));
    } on AuthException catch (e) {
      throw AuthException(e.message, statusCode: e.statusCode);
    } catch (e) {
      throw Exception(
        'An unexpected error occurred while updating password: $e',
      );
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
