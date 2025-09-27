import 'package:paralelo/features/auth/model/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

abstract class AuthRepository {
  Future<AuthUser?> loginWithEmail(String email, String password);
  Future<AuthUser?> loginWithMicrosoft();
  Future<void> logout();
  Future<AuthUser?> currentUser();
}

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient client;

  const SupabaseAuthRepository(this.client);

  @override
  Future<AuthUser?> loginWithEmail(String email, String password) async {
    final _ = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return await currentUser();
  }

  @override
  Future<AuthUser?> loginWithMicrosoft() async {
    final _ = await client.auth.signInWithOAuth(OAuthProvider.azure);

    return await currentUser();
  }

  @override
  Future<void> logout() async {
    await client.auth.signOut();
  }

  @override
  Future<AuthUser?> currentUser() async {
    final user = client.auth.currentUser;

    if (user == null) return null;

    return AuthUser(
      id: user.id,
      email: user.email ?? "",
      pictureUrl: user.userMetadata?['avatar_url'],
    );
  }
}
