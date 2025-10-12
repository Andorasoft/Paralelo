import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/features/user/models/app_user_repository.dart';
import 'package:paralelo/features/user/models/app_user.dart';

final appUserProvider = Provider((ref) {
  final client = Supabase.instance.client;
  final repo = SupabaseAppUserRepository(client);

  return AppUserProvider(repo);
});

class AppUserProvider {
  final AppUserRepository _repo;

  const AppUserProvider(this._repo);

  Future<AppUser?> getById(String id) {
    return _repo.getById(id);
  }

  Future<AppUser?> update(
    String id, {
    String? firstName,
    String? lastName,
    String? email,
    String? pictureUrl,
    int? universityId,
    String? deviceToken,
  }) {
    return _repo.update(
      id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      pictureUrl: pictureUrl,
      universityId: universityId,
      deviceToken: deviceToken,
    );
  }
}
