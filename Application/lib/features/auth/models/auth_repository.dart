import 'package:paralelo/features/auth/models/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

/// Defines authentication-related operations.
abstract class AuthRepository {
  /// Signs in using email and password.
  Future<AuthUser?> loginWithEmail(String email, String password);

  /// Signs in via Microsoft OAuth.
  Future<AuthUser?> loginWithMicrosoft();

  /// Ends the current user session.
  Future<void> logout();

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
  Future<AuthUser?> loginWithEmail(String email, String password) async {
    await _client.auth.signInWithPassword(email: email, password: password);
    return currentUser();
  }

  @override
  Future<AuthUser?> loginWithMicrosoft() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.azure,
      queryParams: {'prompt': 'select_account'},
    );
    return currentUser();
  }

  @override
  Future<void> logout() async {
    await _client.auth.signOut();
  }

  @override
  AuthUser? currentUser() {
    final user = _client.auth.currentUser;

    if (user == null) return null;

    return AuthUser(
      id: user.id,
      email: user.email ?? "",
      pictureUrl: user.userMetadata?['avatar_url'],
    );
  }
}
