import 'package:paralelo/core/imports.dart';
import '../models/application.dart';

abstract class ApplicationRepository {
  Future<Application?> getByPlatform(String platform);
}

class SupabaseApplicationRepository implements ApplicationRepository {
  final SupabaseClient _client;

  const SupabaseApplicationRepository(this._client);

  @override
  Future<Application?> getByPlatform(String platform) async {
    final data = await _client
        .from('application')
        .select()
        .eq('platform', platform)
        .maybeSingle();

    return data != null ? Application.fromMap(data) : null;
  }
}
