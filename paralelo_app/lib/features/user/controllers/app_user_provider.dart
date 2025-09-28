import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/user/models/app_user_repository.dart';
import 'package:paralelo/features/user/models/app_user.dart';

final appUserProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseAppUserRepository(client);

  return _AppUserProvider(repo);
});

class _AppUserProvider {
  final AppUserRepository _repo;

  const _AppUserProvider(this._repo);

  Future<AppUser?> getById(int id) {
    return _repo.getById(id);
  }

  Future<AppUser?> getByEmail(String email) {
    return _repo.getByEmail(email);
  }
}
