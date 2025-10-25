import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';

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
  /// For [AuthProvider.email], both [email] and [password] must be provided.
  Future<void> signIn({String? email, String? password}) async {
    state = await _repo.signIn(email!, password!);
  }

  /// Signs out the current user and clears the auth state.
  Future<void> signOut() async {
    await _repo.singOut();
    state = null;
  }
}
