import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/user/exports.dart';

/// Global provider that exposes authentication state and actions.
///
/// The provider uses [AuthStateNotifier] to manage sign-in, sign-out,
/// and the current [AuthUser] session reactively.
final authProvider = StateNotifierProvider<AuthStateNotifier, AuthUser?>((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseAuthRepository(client);
  return AuthStateNotifier(repo, ref);
});

/// Handles authentication logic and exposes the current [AuthUser] state.
///
/// This class bridges the [AuthRepository] and the app’s reactive state.
/// It updates [state] whenever a user logs in or out.
class AuthStateNotifier extends StateNotifier<AuthUser?> {
  final AuthRepository _repo;
  final StateNotifierProviderRef<AuthStateNotifier, AuthUser?> ref;

  AuthStateNotifier(this._repo, this.ref) : super(null) {
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
    await ref.read(userProvider).update(state!.id, deviceToken: '');
    state = null;
  }
}
