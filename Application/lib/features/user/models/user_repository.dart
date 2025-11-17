import 'package:paralelo/core/imports.dart';
import './user.dart';

/// Repository interface for user data management.
abstract class UserRepository {
  /// Returns a [User] by [id], or `null` if not found.
  Future<User?> getById(String id);

  /// Creates a new [User] record.
  Future<User> create({
    required String id,
    required String displayName,
    required String email,
    String? pictureUrl,
    String? deviceToken,
    required String planId,
    required String universityId,
  });

  /// Updates a [User] with the provided fields.
  Future<User?> update(
    String id, {
    String? displayName,
    String? pictureUrl,
    String? deviceToken,
    int? planId,
  });
}

/// Supabase implementation of [UserRepository].
class SupabaseUserRepository implements UserRepository {
  final SupabaseClient _client;

  const SupabaseUserRepository(this._client);

  @override
  Future<User?> getById(String id) async {
    final data = await _client.from('user').select().eq('id', id).maybeSingle();

    return data != null ? User.fromMap(data) : null;
  }

  @override
  Future<User> create({
    required String id,
    required String displayName,
    required String email,
    String? pictureUrl,
    String? deviceToken,
    required String planId,
    required String universityId,
  }) async {
    final data = await _client
        .from('user')
        .insert({
          'id': id,
          'display_name': displayName,
          'email': email,
          'picture_url': pictureUrl,
          'device_token': deviceToken,
          'plan_id': planId,
          'university_id': universityId,
        })
        .select()
        .single();

    return User.fromMap(data);
  }

  @override
  Future<User?> update(
    String id, {
    String? displayName,
    String? pictureUrl,
    String? deviceToken,
    int? planId,
  }) async {
    final updates = <String, dynamic>{};

    if (displayName != null) {
      updates['display_name'] = displayName;
    }
    if (pictureUrl != null) {
      updates['picture_url'] = pictureUrl;
    }
    if (deviceToken != null) {
      updates['device_token'] = deviceToken;
    }
    if (planId != null) {
      updates['plan_id'] = planId;
    }

    if (updates.isEmpty) return await getById(id);

    final data = await _client
        .from('user')
        .update(updates)
        .eq('id', id)
        .select()
        .maybeSingle();

    return data != null ? User.fromMap(data) : null;
  }
}
