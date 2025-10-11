import 'package:supabase_flutter/supabase_flutter.dart';
import './app_user.dart';

abstract class AppUserRepository {
  Future<AppUser?> getById(String id);
  Future<AppUser?> update(
    String id, {
    String? firstName,
    String? lastName,
    String? email,
    String? pictureUrl,
    int? universityId,
    String? deviceToken,
  });
}

class SupabaseAppUserRepository implements AppUserRepository {
  final SupabaseClient _client;

  const SupabaseAppUserRepository(this._client);

  @override
  Future<AppUser?> getById(String id) async {
    final data = await _client
        .from('app_user')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? AppUser.fromMap(data) : null;
  }

  @override
  Future<AppUser?> update(
    String id, {
    String? firstName,
    String? lastName,
    String? email,
    String? pictureUrl,
    int? universityId,
    String? deviceToken,
  }) async {
    final updates = <String, dynamic>{};

    if (firstName != null) updates['first_name'] = firstName;
    if (lastName != null) updates['last_name'] = lastName;
    if (email != null) updates['email'] = email;
    if (pictureUrl != null) updates['picture_url'] = pictureUrl;
    if (universityId != null) updates['university_id'] = universityId;
    if (deviceToken != null) updates['device_token'] = deviceToken;

    if (updates.isEmpty) {
      return await getById(id);
    }

    final data = await _client
        .from('app_user')
        .update(updates)
        .eq('id', id)
        .select()
        .maybeSingle();

    return data != null ? AppUser.fromMap(data) : null;
  }
}
