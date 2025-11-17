import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/user_preference/models/user_preference.dart';

abstract class UserPreferenceRepository {
  Future<UserPreference?> getForUser(String userId);

  Future<UserPreference> create({required String userId});

  Future<UserPreference?> update(
    String userId, {
    String? language,
    bool? darkMode,
    bool? notificationsEnabled,
  });
}

class SupabaseUserPreferenceRepository implements UserPreferenceRepository {
  final SupabaseClient _client;

  const SupabaseUserPreferenceRepository(this._client);

  @override
  Future<UserPreference?> getForUser(String userId) async {
    final data = await _client
        .from('user_preference')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    return data != null ? UserPreference.fromMap(data) : null;
  }

  @override
  Future<UserPreference> create({required String userId}) async {
    final data = await _client
        .from('user_preference')
        .insert({'user_id': userId})
        .select()
        .single();

    return UserPreference.fromMap(data);
  }

  @override
  Future<UserPreference?> update(
    String userId, {
    String? language,
    bool? darkMode,
    bool? notificationsEnabled,
  }) async {
    final updates = <String, dynamic>{};

    if (language != null) updates['language'] = language;
    if (darkMode != null) updates['dark_mode'] = darkMode;
    if (notificationsEnabled != null) {
      updates['notifications_enabled'] = notificationsEnabled;
    }

    if (updates.isEmpty) return await getForUser(userId);

    final data = await _client
        .from('user_preference')
        .update(updates)
        .eq('user_id', userId)
        .select()
        .maybeSingle();

    return data != null ? UserPreference.fromMap(data) : null;
  }
}
