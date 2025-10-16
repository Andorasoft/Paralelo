import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/university/models/university.dart';

abstract class UniversityRepository {
  Future<University?> getByDomain(String domain);
}

class SupabaseUniversityRepository implements UniversityRepository {
  final SupabaseClient _client;

  const SupabaseUniversityRepository(this._client);

  @override
  Future<University?> getByDomain(String domain) async {
    final data = await _client
        .from('university')
        .select()
        .eq('domain', domain)
        .maybeSingle();

    return data != null ? University.fromMap(data) : null;
  }
}
