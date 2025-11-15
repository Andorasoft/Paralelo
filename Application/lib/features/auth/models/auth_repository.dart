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
    await _client.auth.signInWithPassword(email: email, password: password);
    return currentUser();
  }

  @override
  Future<AuthUser?> signUp({
    required String email,
    required String password,
  }) async {
    final res = await _client.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: 'com.paralelo.andorasoft://callback',
    );

    if (res.user == null) return null;

    final user = res.user!;

    return AuthUser(id: user.id, email: user.email ?? '');
  }

  @override
  Future<void> singOut() async {
    await _client.auth.signOut();
  }

  @override
  AuthUser? currentUser() {
    final user = _client.auth.currentUser;

    if (user == null) return null;

    return AuthUser(id: user.id, email: user.email ?? '');
  }
}
