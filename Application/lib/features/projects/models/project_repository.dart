import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/projects/models/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getAll(String userId);

  Future<(int, int, List<Project>)> getPaginated({
    required String excludedUserId,
    int page = 1,
    int limit = 10,
  });

  Future<List<Project>> getForUser(String userId);

  Future<List<Project>> getByIds(List<int> ids);
}

class SupabaseProjectRepository implements ProjectRepository {
  final SupabaseClient _client;

  const SupabaseProjectRepository(this._client);

  @override
  Future<List<Project>> getAll(String userId) async {
    final data = await _client.from('project').select().neq('owner_id', userId);

    return data.map((i) => Project.fromMap(i)).toList();
  }

  @override
  Future<(int, int, List<Project>)> getPaginated({
    required String excludedUserId,
    int page = 1,
    int limit = 10,
  }) async {
    final start = (page - 1) * limit;
    final end = start + limit - 1;

    final count = await _client
        .from('project')
        .select('id')
        .neq('owner_id', excludedUserId)
        .count();

    final pages = (count.count / limit).ceil();

    final data = await _client
        .from('project')
        .select()
        .neq('owner_id', excludedUserId)
        .order('created_at', ascending: false)
        .range(start, end);

    final projects = (data as List).map((i) => Project.fromMap(i)).toList();

    return (page, pages, projects);
  }

  @override
  Future<List<Project>> getForUser(String userId) async {
    final data = await _client.from('project').select().eq('owner_id', userId);

    return data.map((i) => Project.fromMap(i)).toList();
  }

  @override
  Future<List<Project>> getByIds(List<int> ids) async {
    final data = await _client
        .from('project')
        .select()
        .filter('id', 'in', '(${ids.join(',')})');

    return data.map((i) => Project.fromMap(i)).toList();
  }
}
