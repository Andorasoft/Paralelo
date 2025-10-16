import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import 'package:paralelo/features/auth/models/auth_repository.dart';
import 'package:paralelo/features/auth/models/auth_user.dart';

/// Global provider that exposes authentication state and actions.
///
/// The provider uses [_AuthNotifier] to manage sign-in, sign-out,
/// and the current [AuthUser] session reactively.
final authProvider = StateNotifierProvider<_AuthNotifier, AuthUser?>((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseAuthRepository(client);
  return _AuthNotifier(repo);
});

/// Handles authentication logic and exposes the current [AuthUser] state.
///
/// This class bridges the [AuthRepository] and the app’s reactive state.
/// It updates [state] whenever a user logs in or out.
class _AuthNotifier extends StateNotifier<AuthUser?> {
  final AuthRepository _repo;

  _AuthNotifier(this._repo) : super(null) {
    // Initialize the state with the current authenticated user, if any.
    state = _repo.currentUser();
  }

  /// Signs in the user using the selected [provider].
  ///
  /// For [OAuthProvider.email], both [email] and [password] must be provided.
  Future<void> login({
    String? email,
    String? password,
    OAuthProvider provider = OAuthProvider.email,
  }) async {
    switch (provider) {
      case OAuthProvider.email:
        state = await _repo.loginWithEmail(email!, password!);
        break;
      case OAuthProvider.microsoft:
        state = await _repo.loginWithMicrosoft();
        break;
    }
  }

  /// Signs out the current user and clears the auth state.
  Future<void> logout() async {
    await _repo.logout();
    state = null;
  }
}

/// Supported authentication providers for login.
enum OAuthProvider { email, microsoft }
