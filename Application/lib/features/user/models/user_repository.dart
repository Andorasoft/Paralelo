import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/user/models/user.dart';

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
    required int universityId,
  });

  /// Updates a [User] with the provided fields.
  Future<User?> update(
    String id, {
    String? firstName,
    String? lastName,
    String? email,
    String? pictureUrl,
    int? universityId,
    String? deviceToken,
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
    required int universityId,
  }) async {
    final data = await _client
        .from('user')
        .insert({
          'id': id,
          'display_name': displayName,
          'email': email,
          'picture_url': pictureUrl,
          'device_token': deviceToken,
          'university_id': universityId,
        })
        .select()
        .single();

    return User.fromMap(data);
  }

  @override
  Future<User?> update(
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
