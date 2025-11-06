import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/features/auth/exports.dart';

/// Global provider that exposes authentication state and actions.
///
/// The provider uses [AuthStateNotifier] to manage sign-in, sign-out,
/// and the current [AuthUser] session reactively.
final authProvider = StateNotifierProvider<AuthStateNotifier, AuthUser?>((_) {
  final client = Supabase.instance.client;
  final repo = SupabaseAuthRepository(client);
  return AuthStateNotifier(repo);
});

/// Handles authentication logic and exposes the current [AuthUser] state.
///
/// This class bridges the [AuthRepository] and the app’s reactive state.
/// It updates [state] whenever a user logs in or out.
class AuthStateNotifier extends StateNotifier<AuthUser?> {
  final AuthRepository _repo;

  AuthStateNotifier(this._repo) : super(null) {
    // Initialize the state with the current authenticated user, if any.
    state = _repo.currentUser();
  }

  /// Signs in the user using the selected [provider].
  ///
  /// For [AuthProvider.email], both [email] and [password] must be provided.
  Future<void> signIn({required String email, required String password}) async {
    state = await _repo.signIn(email: email, password: password);
  }

  Future<AuthUser?> signUp({required String email, required String password}) {
    return _repo.signUp(email: email, password: password);
  }

  /// Signs out the current user and clears the auth state.
  Future<void> signOut() async {
    await FCMService.instance.deleteDeviceToken();
    await _repo.singOut();
    state = null;
  }
}
