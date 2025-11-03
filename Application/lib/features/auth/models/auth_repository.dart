import 'package:paralelo/core/imports.dart';
import '../models/auth_user.dart';

/// Defines authentication-related operations.
abstract class AuthRepository {
  /// Signs in using email and password.
  Future<AuthUser?> signIn({required String email, required String password});

  Future<AuthUser?> signUp({required String email, required String password});

  /// Ends the current user session.
  Future<void> singOut();

  /// Returns the currently signed-in user, or `null` if no session exists.
  AuthUser? currentUser();
}

/// Supabase implementation of [AuthRepository].
///
/// Handles all authentication logic using Supabase Auth.
/// Supports both email/password and Microsoft (Azure) OAuth login.
class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _client;

  const SupabaseAuthRepository(this._client);

  @override
  Future<AuthUser?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      return currentUser();
    } catch (err) {
      return null;
    }
  }

  @override
  Future<AuthUser?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'com.paralelo.andorasoft://callback',
      );
      return AuthUser(id: res.user!.id, email: res.user!.email ?? '');
    } catch (err) {
      return null;
    }
  }

  @override
  Future<void> singOut() async {
    try {
      await _client.auth.signOut();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  AuthUser? currentUser() {
    final user = _client.auth.currentUser;

    if (user == null) return null;

    return AuthUser(id: user.id, email: user.email ?? '');
  }
}
