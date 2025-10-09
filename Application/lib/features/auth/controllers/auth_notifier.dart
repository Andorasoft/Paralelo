import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import 'package:paralelo/features/auth/models/auth_repository.dart';
import 'package:paralelo/features/auth/models/auth_user.dart';

final authProvider = StateNotifierProvider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseAuthRepository(client);

  return _AuthNotifier(repo);
});

class _AuthNotifier extends StateNotifier<AuthUser?> {
  final AuthRepository _repository;

  _AuthNotifier(this._repository) : super(null) {
    _repository.currentUser().then((value) => state = value);
  }

  Future<void> login({
    String? email,
    String? password,
    String provider = 'email',
  }) async {
    assert(['email', 'microsoft'].contains(provider), '');

    switch (provider) {
      case 'email':
        state = await _repository.loginWithEmail(email!, password!);
        break;
      case 'microsoft':
        state = await _repository.loginWithMicrosoft();
        break;
      default:
        throw Exception();
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = null;
  }
}
