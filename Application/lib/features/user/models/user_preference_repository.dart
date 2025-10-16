import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/user/models/user_preference.dart';

abstract class UserPreferenceRepository {
  Future<UserPreference?> getForUser(String userId);

  Future<UserPreference> create({required String userId});
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
}
