import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import 'package:paralelo/features/auth/model/auth_repository.dart';
import 'package:paralelo/features/auth/model/auth_user.dart';

final authProvider = StateNotifierProvider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseAuthRepository(client);

  return AuthNotifier(repo);
});

class AuthNotifier extends StateNotifier<AuthUser?> {
  final AuthRepository repository;

  AuthNotifier(this.repository) : super(null) {
    repository.currentUser().then((value) => state = value);
  }

  Future<void> login({
    String? email,
    String? password,
    String provider = 'email',
  }) async {
    assert(['email', 'microsoft'].contains(provider), '');

    switch (provider) {
      case 'email':
        state = await repository.loginWithEmail(email!, password!);

      case 'microsoft':
        state = await repository.loginWithMicrosoft();
    }
  }

  Future<void> logout() async {
    await repository.logout();
    state = null;
  }
}
