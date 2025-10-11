import 'package:supabase_flutter/supabase_flutter.dart';
import './project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getAll(String userId, {required bool includeRelations});

  Future<Project?> getById(int id, {required bool includeRelations});
}

class SupabaseProjectRepository implements ProjectRepository {
  final SupabaseClient _client;

  const SupabaseProjectRepository(this._client);

  @override
  Future<List<Project>> getAll(
    String userId, {
    required bool includeRelations,
  }) async {
    final data = await _client
        .from('project')
        .select(includeRelations ? '*, owner:app_user(*)' : '*')
        .neq('owner_id', userId);

    return data.map((i) => Project.fromMap(i)).toList();
  }

  @override
  Future<Project?> getById(int id, {required bool includeRelations}) async {
    final data = await _client
        .from('project')
        .select(includeRelations ? '*, owner:app_user(*)' : '*')
        .eq('id', id)
        .maybeSingle();

    return data != null ? Project.fromMap(data) : null;
  }
}
