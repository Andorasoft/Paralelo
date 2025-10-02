import 'package:supabase_flutter/supabase_flutter.dart';
import './app_user.dart';

abstract class AppUserRepository {
  Future<AppUser?> getById(int id);
  Future<AppUser?> getByEmail(String email);
}

class SupabaseAppUserRepository implements AppUserRepository {
  final SupabaseClient _client;

  const SupabaseAppUserRepository(this._client);

  @override
  Future<AppUser?> getById(int id) async {
    final data = await _client
        .from('app_user')
        .select()
        .eq('id', id)
        .maybeSingle();

    return data != null ? _fromMap(data) : null;
  }

  @override
  Future<AppUser?> getByEmail(String email) async {
    final data = await _client
        .from('app_user')
        .select()
        .eq('email', email)
        .maybeSingle();

    return data != null ? _fromMap(data) : null;
  }

  AppUser _fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      pictureUrl: map['picture_url'],
      universityId: map['university_id'],
      deviceToken: map['device_token'],
    );
  }
}
